//
//  BrowseFilter.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import Combine

class BrowseFilter: ObservableObject {
    var acidity: Int?
    var available: Bool?
    var bitterness: Int?
    var body: Int?
    var cup: String?
    var decaffeinated: Bool?
    var intensity: Int?
    var isDirty: Bool = false
    var roasting: Int?
    
    public var active: Bool {
        self.acidity != nil ||
            self.available != nil ||
            self.bitterness != nil ||
            self.body != nil ||
            self.cup != nil ||
            self.decaffeinated != nil ||
            self.intensity != nil ||
            self.roasting != nil
    }
    
    init(_ data: [String: Any]? = nil) {
        if let data = data {
            self.isDirty = true
            self.acidity = data["acidity"] as? Int
            self.available = data["available"] as? Bool
            self.bitterness = data["bitterness"] as? Int
            self.body = data["body"] as? Int
            self.cup = data["cup"] as? String
            self.decaffeinated = data["decaffeinated"] as? Bool
            self.intensity = data["intensity"] as? Int
            self.roasting = data["roasting"] as? Int
        }
    }
}
