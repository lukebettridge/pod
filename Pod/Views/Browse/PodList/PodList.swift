//
//  PodList.swift
//  Pod
//
//  Created by Luke Bettridge on 29/12/2020.
//

import SwiftUI

struct PodList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var brand: Brand
    @Binding var filter: PodFilter
    
    @StateObject private var podListVM: PodListViewModel
    @StateObject private var searchBar = SearchBar()
    
    @State private var selectedVariety = 0
    @State private var selectedPod: Pod?
    
    init(brand: Brand, filter: Binding<PodFilter>) {
        self.brand = brand
        self._filter = filter
        self._podListVM = StateObject(wrappedValue: PodListViewModel(brand: brand))
    }
    
    var body: some View {
        Group {
            if podListVM.isLoading {
                ProgressView()
            }
            else {
                ScrollView(.vertical) {
                    
                    if podListVM.varieties.count > 1 {
                        Picker("Variety", selection: $selectedVariety) {
                            ForEach(podListVM.varieties, id: \.self) { variety in
                                if let index = podListVM.varieties.firstIndex(of: variety) {
                                    Text(variety).tag(index)
                                }
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                    }
                    
                    VStack {
                        if podListVM.filteredCategories.count > 0 {
                            if RemoteConfig.config.boolValue(forKey: .show_recently_added) {
                                if !filter.active && searchBar.text.isEmpty {
                                    PodListRecentlyAdded(
                                        pods: $podListVM.filteredPods,
                                        selectedPod: $selectedPod
                                    )
                                }
                            }
                            ForEach(podListVM.filteredCategories) { category in
                                if let pods = podListVM.filteredPods.filter { $0.category?.id == category.id } {
                                    if !pods.isEmpty {
                                        Section(
                                            header:
                                                VStack(alignment: .leading, spacing: 5) {
                                                    Text((category.name ?? "").uppercased())
                                                        .font(.custom("FSLucasPro-Bold", size: 18))
                                                    Text(category.description ?? "")
                                                        .font(.caption)
                                                        .foregroundColor(Color.gray)
                                                        .fixedSize(horizontal: false, vertical: true)
                                                }
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding()
                                        ) {
                                            PodListGrid(
                                                pods: pods,
                                                selectPod: { pod in selectedPod = pod },
                                                preferredSubtitle: category.name == "Limited Edition" ? .year : .origin
                                            )
                                        }
                                    }
                                }
                            }
                        } else {
                            PodListGrid(
                                pods: podListVM.filteredPods,
                                selectPod: { pod in selectedPod = pod }
                            )
                        }
                    }
                    .sheet(item: $selectedPod) {
                        PodPage(pod: $0, exit: { selectedPod = nil })
                            .environment(\.managedObjectContext, managedObjectContext)
                    }
                    
                    Group {
                        if podListVM.filteredPods.count > 0 {
                            Divider()
                                .padding(.top, 20)
                        }
                        PodListRequest()
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                    
                }
            }
        }
        .onChange(of: filter.isDirty, perform: { isDirty in
            if isDirty {
                filter.isDirty = false
                podListVM.filterResults(filter: filter, query: searchBar.text, varietyIndex: selectedVariety)
            }
        })
        .onChange(of: searchBar.text, perform: { searchText in
            podListVM.filterResults(filter: filter, query: searchText, varietyIndex: selectedVariety)
        })
        .onChange(of: selectedVariety, perform: { selectedVariety in
            podListVM.filterResults(filter: filter, query: searchBar.text, varietyIndex: selectedVariety)
        })
//        .navigationBarTitle(brand.name ?? "")
        .add(searchBar)
    }
}
