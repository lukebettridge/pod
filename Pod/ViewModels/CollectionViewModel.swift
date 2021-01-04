//
//  CollectionViewModel.swift
//  Pod
//
//  Created by Luke Bettridge on 26/12/2020.
//

import Combine
import Resolver

class CollectionViewModel: ObservableObject {
    @Published var podRepository: PodRepository = Resolver.resolve()
    @Published var pods: [Pod] = []
    @Published var isLoading = false
    
    init() {
        self.isLoading = true
        podRepository.get { pods in
            self.pods = pods
            self.isLoading = false
        }
    }
}
