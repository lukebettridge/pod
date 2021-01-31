//
//  MostPopularItem.swift
//  Pod
//
//  Created by Luke Bettridge on 30/01/2021.
//

class MostPopularItem {
    var podId: String?
    var count: Int?
    
    init(_ data: [String: Any]) {
        self.podId = data["capsule_id"] as? String
        self.count = data["count"] as? Int
    }
}
