//
//  LogViewModel.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import Combine
import Resolver

class LogViewModel: ObservableObject {
    private var podRepository: PodRepository = Resolver.resolve()
    
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

