//
//  RemoteConfig.swift
//  Pod
//
//  Created by Luke Bettridge on 28/01/2021.
//

import Firebase

class RemoteConfig {
    static let config = RemoteConfig()
    
    private init() {
        let config = Firebase.RemoteConfig.remoteConfig()
        
        let defaults: [String: Any?] = [
            ValueKey.featured.rawValue: nil,
            ValueKey.most_popular.rawValue: [],
            ValueKey.show_recently_added.rawValue: true,
            ValueKey.show_trends_coming_soon.rawValue: false,
            ValueKey.top_favourites.rawValue: []
        ]
        config.setDefaults(defaults as? [String: NSObject])
    
        config.fetch(withExpirationDuration: 0) { status, err in
            if let err = err {
                print("Error fetching config: \(err)")
            } else {
                config.activate()
            }
          }
    }
    
    func boolValue(forKey key: ValueKey) -> Bool {
        return Firebase.RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }
    
    func jsonValue(forKey key: ValueKey) -> Any? {
        return Firebase.RemoteConfig.remoteConfig()[key.rawValue].jsonValue
    }
    
    enum ValueKey: String {
        case featured, most_popular, show_recently_added, show_trends_coming_soon, top_favourites
    }
}
