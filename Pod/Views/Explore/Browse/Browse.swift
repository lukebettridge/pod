//
//  Browse.swift
//  Pod
//
//  Created by Luke Bettridge on 31/01/2021.
//

import SwiftUI
import Introspect

struct Browse: View {
    @EnvironmentObject var vm: ContentViewModel
    
    @StateObject var browseVM: BrowseViewModel
    @StateObject var searchBar = SearchBar()
    @State var filter = BrowseFilter()
    @State var variety = 0
    
    let title: String
    let brand: Brand?
    let varieties = ["Original", "Vertuo"]
    
    var pods: [Pod] {
        vm.pods.filter {
            (brand == nil || $0.brand?.id == brand?.id) &&
                (varieties.count == 0 || $0.variety == varieties[variety]) &&
                (searchBar.text.isEmpty || ($0.name ?? "").localizedStandardContains(searchBar.text)) &&
                (!filter.active || browseVM.criteria(filter, pod: $0))
        }
    }
    
    // Too slow
    //var varieties: [String] {
    //    vm.pods.filter { brand == nil || $0.brand?.id == brand?.id }
    //        .compactMap() { pod in pod.variety }.unique
    //        .sorted { $0.lowercased() < $1.lowercased() }
    //}
    
    init(
        title: String = "Browse",
        brand: Brand? = nil
    ) {
        self.title = title
        self.brand = brand
        self._browseVM = StateObject(wrappedValue: BrowseViewModel(brand: brand))
    }
    
    var body: some View {
        VStack {
            if vm.isLoading || browseVM.isLoading {
                ProgressView()
            } else {
                ScrollView(.vertical) {
                    VStack {
                        BrowsePicker(varieties: varieties, variety: $variety)
                        if RemoteConfig.config.boolValue(forKey: .show_recently_added) {
                            if !filter.active && searchBar.text.isEmpty {
                                BrowseRecentlyAdded()
                                    .environment(\.pods, pods)
                            }
                        }
                        ForEach(browseVM.categories) { category in
                            if let pods = pods.filter { $0.category?.id == category.id } {
                                if pods.count > 0 {
                                    BrowseSection(category)
                                        .environment(\.pods, pods)
                                }
                            }
                        }
                        if pods.count == 0 {
                            BrowseRequest()
                                .padding()
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .navigationBarTitle(title)
        .navigationBarItems(
            trailing:
                Button(action: {
                    vm.openSheet(.filter, filter: $filter)
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle\(filter.active ? ".fill" : "")")
                        .font(.title2)
                }
        )
        .introspectNavigationController { UINavigationController in
            UINavigationController.navigationItem.searchController = self.searchBar.searchController
        }
        .onAppear {
            self.variety = UserDefaults.standard.integer(forKey: "Variety")
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: title,
                Analytics.AnalyticsParameterScreenClass: "Browse"
            ])
        }
    }
}
