//
//  PodList.swift
//  Pod
//
//  Created by Luke Bettridge on 29/12/2020.
//

import SwiftUI

struct PodList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject private var podListVM: PodListViewModel
    @StateObject private var searchBar = SearchBar()
    var brand: Brand
    
    @State private var selectedVariety = 0
    @State private var selectedPod: Pod?
    
    init(brand: Brand) {
        self.brand = brand
        _podListVM = StateObject(wrappedValue: PodListViewModel(brand: brand))
    }
    
    var body: some View {
        Group {
            if podListVM.isLoading {
                ProgressView()
            }
            else {
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
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
                        
                        if podListVM.filteredCategories.count > 0 {
                            ForEach(podListVM.filteredCategories) { category in
                                Section(
                                    header:
                                        VStack(alignment: .leading) {
                                            Text((category.name ?? "").uppercased())
                                                .font(.custom("FSLucasPro-Bold", size: 18))
                                                .padding(.bottom, 0.1)
                                            Text(category.description ?? "")
                                                .font(.caption)
                                                .foregroundColor(Color.gray)
                                        }
                                        .padding()
                                ) {
                                    PodListGrid(
                                        pods: podListVM.filteredPods.filter { $0.category?.id == category.id },
                                        selectPod: { pod in selectedPod = pod },
                                        isLimitedEdition: category.name == "Limited Edition"
                                    )
                                }
                            }
                        } else {
                            PodListGrid(
                                pods: podListVM.filteredPods,
                                selectPod: { pod in selectedPod = pod }
                            )
                        }
                    }
                    .padding(.top, 7.5)
                    .padding(.bottom, 30)
                }
                .sheet(item: $selectedPod) {
                    PodPage(pod: $0, exit: { selectedPod = nil })
                        .environment(\.managedObjectContext, managedObjectContext)
                }
            }
        }
        .onChange(of: searchBar.text, perform: { searchText in
            podListVM.filterResults(query: searchText, varietyIndex: selectedVariety)
        })
        .onChange(of: selectedVariety, perform: { selectedVariety in
            podListVM.filterResults(query: searchBar.text, varietyIndex: selectedVariety)
        })
//        .navigationBarTitle(brand.name ?? "")
        .add(searchBar)
    }
}
