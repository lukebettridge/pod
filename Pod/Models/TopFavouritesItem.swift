//
//  TopFavouritesItem.swift
//  Pod
//
//  Created by Luke Bettridge on 05/02/2021.
//

class TopFavouritesItem {
    var podId: String?
    var count: Int?
    
    init(_ data: [String: Any]) {
        self.podId = data["capsule_id"] as? String
        self.count = data["count"] as? Int
    }
}
