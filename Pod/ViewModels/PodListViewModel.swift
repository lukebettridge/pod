//
//  PodListViewModel.swift
//  Pod
//
//  Created by Luke Bettridge on 29/12/2020.
//

import Combine
import Resolver

class PodListViewModel: ObservableObject {
    private var PodRepository: PodRepository = Resolver.resolve()
    private var CategoryRepository: CategoryRepository = Resolver.resolve()
    
    @Published private var pods: [Pod] = []
    @Published private var categories: [Category] = []
    
    @Published var filteredPods: [Pod] = []
    @Published var filteredCategories: [Category] = []
    
    @Published var isLoadingPods = false
    @Published var isLoadingCategories = false
    var isLoading: Bool {
        isLoadingPods || isLoadingCategories
    }
    
    var varieties: [String] {
        pods.compactMap() { pod in pod.variety }.unique
            .sorted { $0.lowercased() < $1.lowercased() }
    }
    
    init(brand: Brand) {
        self.isLoadingPods = true
        self.isLoadingCategories = true
        PodRepository.getByBrand(brand: brand) { pods in
            self.pods = pods
            self.filteredPods = pods.filter {
                self.varieties.count < 2 || self.varieties[0] == $0.variety ?? ""
            }
            self.isLoadingPods = false
        }
        CategoryRepository.getByBrand(brand: brand) { categories in
            self.categories = categories
            self.filteredCategories = categories
            self.isLoadingCategories = false
        }
    }
    
    func filterResults(query: String, varietyIndex: Int?) -> Void {
        self.filteredPods = self.pods.filter {
            (query.isEmpty || ($0.name ?? "").localizedStandardContains(query)) &&
                (self.varieties.count < 2 || self.varieties[varietyIndex ?? 0] == $0.variety ?? "")
        }
        self.filteredCategories = categories.filter { category in
            self.filteredPods.contains(where: { pod in pod.category?.id == category.id })
        }
    }
}
