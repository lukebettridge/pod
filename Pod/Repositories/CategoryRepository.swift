//
//  CategoryRepository.swift
//  Pod
//
//  Created by Luke Bettridge on 30/12/2020.
//

import FirebaseFirestore

class CategoryRepository {
    private let store = Firestore.firestore()
    
    func getByBrand(brand: Brand, completion: @escaping ([Category]) -> Void) {
        if let id = brand.id {
            let brandReference = store
                .collection("brands")
                .document(id)
            store
                .collection("categories")
                .whereField("brand", isEqualTo: brandReference)
                .order(by: "name")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting brands: \(err)")
                    } else {
                        completion(
                            querySnapshot?.documents.compactMap() { document in
                                Category(document.data(), documentID: document.documentID)
                            } ?? []
                        )
                    }
                }
        }
    }
}

