//
//  PodRepository.swift
//  Pod
//
//  Created by Luke Bettridge on 23/12/2020.
//

import FirebaseFirestore

class PodRepository {
    private let store = Firestore.firestore()
    
    func get(completion: @escaping ([Pod]) -> Void) {
        store
            .collection("pods")
            .order(by: "category")
            .order(by: "name")
            .order(by: "decaffeinated")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting pods: \(err)")
                } else {
                    completion(
                        querySnapshot?.documents.compactMap() { document in
                            Pod(document.data(), documentID: document.documentID)
                        } ?? []
                    )
                }
            }
    }
    
    func getByBrand(brand: Brand, completion: @escaping ([Pod]) -> Void) {
        if let id = brand.id {
            let brandReference = store
                .collection("brands")
                .document(id)
            store
                .collection("pods")
                .whereField("brand", isEqualTo: brandReference)
                .order(by: "category")
                .order(by: "name")
                .order(by: "decaffeinated")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting pods: \(err)")
                    } else {
                        completion(
                            querySnapshot?.documents.compactMap() { document in
                                Pod(document.data(), documentID: document.documentID)
                            } ?? []
                        )
                    }
                }
        }
    }
}
