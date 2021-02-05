//
//  BrowseViewModel.swift
//  Pod
//
//  Created by Luke Bettridge on 28/12/2020.
//

import Combine
import Resolver

class BrowseViewModel: ObservableObject {
    private var categoryRepository: CategoryRepository = Resolver.resolve()
    
    @Published var categories: [Category] = []
    @Published var isLoading = true
    
    init(brand: Brand?) {
        getCategories(brand: brand)
    }
    
    func getCategories(brand: Brand?) {
        if let brand = brand {
            categoryRepository.getByBrand(brand) { categories in
                self.categories = categories
                self.isLoading = false
            }
        } else {
            categoryRepository.get { categories in
                self.categories = categories
                self.isLoading = false
            }
        }
    }
    
    func criteria(_ filter: BrowseFilter, pod: Pod) -> Bool {
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
