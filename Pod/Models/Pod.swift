//
//  Pod.swift
//  Pod
//
//  Created by Luke Bettridge on 23/12/2020.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class Pod: ObservableObject, Identifiable, Equatable {
    static func == (lhs: Pod, rhs: Pod) -> Bool {
        lhs._id == rhs._id
    }
    
    @DocumentID var id: String?
    var brand: Brand?
    var caffeine: Double
    var category: Category?
    var color: Color
    var cupSize: [String]
    var decaffeinated: Bool?
    var description: String?
    var image: Image
    var intensity: Int?
    var introduced: Int?
    var name: String?
    var notes: [String]?
    var origin: String?
    var price: Double?
    var productLink: String?
    var profile: String?
    var ratings: Dictionary<RatingType, Int> = [:]
    var tip: String?
    var variety: String?
    
    init(_ data: [String: Any], documentID: String?) {
        self.id = data["id"] as? String ?? documentID
        self.cupSize = data["cupSize"] as? [String] ?? []
        self.decaffeinated = data["decaffeinated"] as? Bool
        self.description = data["description"] as? String
        self.caffeine = data["caffeine"] as? Double ?? 60
        self.intensity = data["intensity"] as? Int
        self.introduced = data["introduced"] as? Int
        self.name = data["name"] as? String
        self.notes = data["notes"] as? [String]
        self.origin = data["origin"] as? String
        self.price = data["price"] as? Double
        self.productLink = data["productLink"] as? String
        self.profile = data["profile"] as? String
        self.tip = data["tip"] as? String
        self.variety = data["variety"] as? String
        
        if let acidity = data["acidity"] as? Int {
            self.ratings[.acidity] = acidity
        }
        if let bitterness = data["bitterness"] as? Int {
            self.ratings[.bitterness] = bitterness
        }
        if let body = data["body"] as? Int {
            self.ratings[.body] = body
        }
        if let roasting = data["roasting"] as? Int {
            self.ratings[.roasting] = roasting
        }
        
        self.color = Color(UIColor.systemGray2)
        if let color = data["color"] as? String {
            self.color = Color(hex: color)
        }
        
        self.image = Image(uiImage: UIImage(named: "Placeholder")!)
        if let image = data["image"] as? String {
            fetchImage(image) { data in
                self.image = Image(uiImage: UIImage(data: data)!)
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

enum RatingType {
    case acidity, bitterness, body, roasting
}
