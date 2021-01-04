//
//  PodRowViewModel.swift
//  Pod
//
//  Created by Luke Bettridge on 23/12/2020.
//

import UIKit
import Combine
import FirebaseStorage

class PodRowViewModel: ObservableObject, Identifiable {
    @Published var pod: Pod
    
    init(pod: Pod) {
        self.pod = pod
        
        if (pod.imageUrl != nil) {
            let storage = Storage.storage()
            let ref = storage.reference(withPath: pod.imageUrl!)
            
            ref.getData(maxSize: 1 * 1024 * 1024) { (data, err) in
                if let err = err {
                    print("Error fetching image: \(err)")
                } else {
                    self.pod.imageData = data
                }
            }
        }
        
        
    }
}
