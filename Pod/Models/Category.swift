//
//  Category.swift
//  Pod
//
//  Created by Luke Bettridge on 30/12/2020.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class Category: Identifiable, Codable {
    @DocumentID var id: String?
    var description: String?
    var name: String?
    
    init(_ data: [String: Any], documentID: String?) {
        self.id = data["id"] as? String ?? documentID
        self.description = data["description"] as? String
        self.name = data["name"] as? String
    }
}
