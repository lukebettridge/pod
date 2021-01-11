//
//  Brand.swift
//  Pod
//
//  Created by Luke Bettridge on 28/12/2020.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class Brand: ObservableObject, Identifiable {
    @DocumentID var id: String?
    var cover: Image
    var color: String?
    var logo: Image
    var name: String?
    var order: Int?
    
    init(_ data: [String: Any], documentID: String?) {
        self.id = data["id"] as? String ?? documentID
        self.color = data["color"] as? String
        self.name = data["name"] as? String
        self.order = data["order"] as? Int
        
        self.cover = Image(uiImage: UIImage(named: "Placeholder")!)
        self.logo = Image(uiImage: UIImage(named: "Placeholder")!)
        
        if let cover = data["cover"] as? String {
            fetchImage(cover) { data in
                self.cover = Image(uiImage: UIImage(data: data)!)
            }
        }
        
        if let logo = data["logo"] as? String {
            fetchImage(logo) { data in
                self.logo = Image(uiImage: UIImage(data: data)!)
            }
        }
    }
}

