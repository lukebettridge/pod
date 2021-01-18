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
    
    func filterResults(filter: PodFilter, query: String, varietyIndex: Int?) -> Void {
        self.filteredPods = self.pods.filter {
            (query.isEmpty || ($0.name ?? "").localizedStandardContains(query)) &&
                (self.varieties.count < 2 || self.varieties[varietyIndex ?? 0] == $0.variety ?? "") &&
                self.filterCriteria(filter: filter, pod: $0)
        }
        self.filteredCategories = categories.filter { category in
            self.filteredPods.contains(where: { pod in pod.category?.id == category.id })
        }
    }
    
    private func filterCriteria(filter: PodFilter, pod: Pod) -> Bool {
        // Acidity
        if let acidity = filter.acidity {
            if pod.ratings[.acidity] != acidity {
                return false
            }
        }
        
        // Available
        if let available = filter.available {
            if pod.available != available {
                return false
            }
        }
        
        // Bitterness
        if let bitterness = filter.bitterness {
            if pod.ratings[.bitterness] != bitterness {
                return false
            }
        }
        
        // Body
        if let body = filter.body {
            if pod.ratings[.body] != body {
                return false
            }
        }
        
        // Cup
        if let cup = filter.cup {
            if !pod.cupSize.contains(cup) {
                return false
            }
        }
        
        // Decaffeinated
        if let decaffeinated = filter.decaffeinated {
            if pod.decaffeinated != decaffeinated {
                return false
            }
        }
        
        // Intensity
        if let intensity = filter.intensity {
            if pod.intensity != intensity {
                return false
            }
        }
        
        // Roasting
        if let roasting = filter.roasting {
            if pod.ratings[.roasting] != roasting {
                return false
            }
        }
        return true
    }
}
