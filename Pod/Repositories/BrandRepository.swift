//
//  BrandRepository.swift
//  Pod
//
//  Created by Luke Bettridge on 28/12/2020.
//

import FirebaseFirestore

class BrandRepository {
    private let store = Firestore.firestore()
    
    func get(completion: @escaping ([Brand]) -> Void) {
        store
            .collection("brands")
            .order(by: "order")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting brands: \(err)")
                } else {
                    completion(
                        querySnapshot?.documents.compactMap() { document in
                            Brand(document.data(), documentID: document.documentID)
                        } ?? []
                    )
                }
            
        }
    }
}
