//
//  FeaturedConfig.swift
//  Pod
//
//  Created by Luke Bettridge on 02/02/2021.
//

import SwiftUI

class FeaturedConfig: ObservableObject {
    var backgroundColor: Color?
    var backgroundImage: [ColorScheme: Image] = [:]
    var foregroundColor: [ColorScheme: Color] = [:]
    var podIds: [String]?
    var subtitle: String?
    var tag: String?
    var title: String?
    
    init(_ data: [String: Any]) {
        self.podIds = data["capsule_ids"] as? [String]
        self.subtitle = data["subtitle"] as? String
        self.tag = data["tag"] as? String
        self.title = data["title"] as? String
        
        if let backgroundColor = data["background_color"] as? String {
            self.backgroundColor = Color(hex: backgroundColor)
        }
        if let backgroundImage = data["background_image"] as? [String: Any] {
            if let light = backgroundImage["light"] as? String {
                fetchImage(light) { data in
                    self.backgroundImage[.light] = Image(uiImage: UIImage(data: data)!)
                    self.objectWillChange.send()
                }
            }
            if let dark = backgroundImage["dark"] as? String {
                fetchImage(dark) { data in
                    self.backgroundImage[.dark] = Image(uiImage: UIImage(data: data)!)
                    self.objectWillChange.send()
                }
            }
        }
        if let foregroundColor = data["foreground_color"] as? [String: Any] {
            if let light = foregroundColor["light"] as? String {
                self.foregroundColor[.light] = Color(hex: light)
            }
            if let dark = foregroundColor["dark"] as? String {
                self.foregroundColor[.dark] = Color(hex: dark)
            }
        }
    }
}
