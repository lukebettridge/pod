//
//  Brand.swift
//  Pod
//
//  Created by Luke Bettridge on 28/12/2020.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class Brand: Identifiable, Codable {
    @DocumentID var id: String?
    var cover: Data?
    var coverUrl: String?
    var color: String?
    var logo: Data?
    var logoUrl: String?
    var name: String?
    var order: Int?
    
    init(_ data: [String: Any], documentID: String?) {
        self.id = data["id"] as? String ?? documentID
        self.color = data["color"] as? String
        self.name = data["name"] as? String
        self.order = data["order"] as? Int
        
        if let coverUrl = data["cover"] as? String {
            fetchImage(coverUrl) { data in self.cover = data }
        }
        if let logoUrl = data["logo"] as? String {
            fetchImage(logoUrl) { data in self.logo = data }
        }
    }
}

