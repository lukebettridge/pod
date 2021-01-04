//
//  Pod.swift
//  Pod
//
//  Created by Luke Bettridge on 23/12/2020.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class Pod: ObservableObject, Identifiable {
    @DocumentID var id: String?
    var brand: Brand?
    var category: Category?
    var color: String?
    var cupSize: [String]?
    var decaffeinated: Bool?
    var description: String?
    var image: Data?
    var intensity: Int?
    var name: String?
    var origin: String?
    var price: Double?
    var profile: [String]?
    var variety: String?
    
    init(_ data: [String: Any], documentID: String?) {
        self.id = data["id"] as? String ?? documentID
        self.color = data["color"] as? String
        self.cupSize = data["cupSize"] as? [String]
        self.decaffeinated = data["decaffeinated"] as? Bool
        self.description = data["description"] as? String
        self.intensity = data["intensity"] as? Int
        self.name = data["name"] as? String
        self.origin = data["origin"] as? String
        self.price = data["price"] as? Double
        self.profile = data["profile"] as? [String]
        self.variety = data["variety"] as? String
        
        if let image = data["image"] as? String {
            fetchImage(image) { data in
                self.image = data
                self.objectWillChange.send()
            }
        }
        
        if let brand = data["brand"] as? DocumentReference {
            brand.getDocument { (documentSnapshot, err) in
                if let document = documentSnapshot, let data = document.data() {
                    self.brand = Brand(data, documentID: document.documentID)
                    self.objectWillChange.send()
                }
            }
        }
        
        if let category = data["category"] as? DocumentReference {
            // Ensure we have an ID for immediate filtering
            self.category = Category(Dictionary(), documentID: category.documentID)
            
            category.getDocument { (documentSnapshot, err) in
                if let document = documentSnapshot, let data = document.data() {
                    self.category = Category(data, documentID: document.documentID)
                    self.objectWillChange.send()
                }
            }
        }
    }
}
