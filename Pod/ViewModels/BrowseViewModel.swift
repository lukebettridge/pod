//
//  BrowseViewModel.swift
//  Pod
//
//  Created by Luke Bettridge on 28/12/2020.
//

import Combine
import Resolver

class BrowseViewModel: ObservableObject {
    @Published var brandRepository: BrandRepository = Resolver.resolve()
    @Published var brands: [Brand] = []
    @Published var isLoading = false
    
    init() {
        self.isLoading = true
        brandRepository.get { brands in
            self.brands = brands
            self.isLoading = false
        }
    }
}
