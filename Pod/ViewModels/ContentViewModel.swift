//
//  ContentViewModel.swift
//  Pod
//
//  Created by Luke Bettridge on 31/01/2021.
//

import SwiftUI
import Combine
import Resolver

enum ContentViewActiveSheet: Identifiable {
    case favourites, filter, log, pod, scanner, welcome
    var id: Int { hashValue }
}

class ContentViewModel: ObservableObject {
    private var brandRepository: BrandRepository = Resolver.resolve()
    private var podRepository: PodRepository = Resolver.resolve()
    
    @Published var brands: [Brand] = []
    @Published var pods: [Pod] = []
    
    @Published var isLoadingBrands = true
    @Published var isLoadingPods = true
    var isLoading: Bool {
        isLoadingBrands || isLoadingPods
    }
    
    var selectedFilter: Binding<BrowseFilter>? = nil
    @Published var selectedPod: Pod? = nil
    @Published var activeSheet: ContentViewActiveSheet? = nil
    
    init() {
        getBrands()
        getPods()
    }
    
    func getBrands() {
        brandRepository.get { brands in
            self.brands = brands
            self.isLoadingBrands = false
        }
    }
    
    func getPods() {
        podRepository.get { pods in
            self.pods = pods
            self.isLoadingPods = false
        }
    }
    
    func closeSheet() {
        activeSheet = nil
    }
    
    func openSheet(_ sheet: ContentViewActiveSheet) {
        closeSheet()
        activeSheet = sheet
    }
    
    func openSheet(_ sheet: ContentViewActiveSheet, pod: Pod) {
        closeSheet()
        self.selectedPod = pod
        activeSheet = sheet
    }
    
    func openSheet(_ sheet: ContentViewActiveSheet, filter: Binding<BrowseFilter>) {
        closeSheet()
        self.selectedFilter = filter
        activeSheet = sheet
    }
}
