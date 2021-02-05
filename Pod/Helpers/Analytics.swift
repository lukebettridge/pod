//
//  Analytics.swift
//  Pod
//
//  Created by Luke Bettridge on 19/01/2021.
//

import FirebaseAnalytics

class Analytics {
    static func log(event: AnalyticsEvent, data: Any?) {
        switch event {
        case .addToCollection:
            logAddToCollection(data: data as? [String: Any])
            break
        case .addToFavourites:
            logAddToFavourites(data: data as? [String: Any])
            break
        case .filter:
            logFilter(data: data as? [String: Any])
        case .logCoffee:
            logCoffee(data: data as? [String: Any])
            break
        case .purchaseClick:
            logPurchaseClick(data: data as? [String: Any])
            break
        case .scanBarcode:
            logScanBarcode(data: data as? [String: Any])
        case .search:
            logSearch(term: data as? String)
            break
        case .view:
            logView(data: data as? [String: Any])
            break
        }
    }
    
    // Custom Events
    static let AnalyticsEventAddToCollection: String = "add_to_collection"
    static let AnalyticsEventAddToFavourites: String = "add_to_favourites"
    static let AnalyticsEventFilter: String = "filter"
    static let AnalyticsEventLogCoffee: String = "log_coffee"
    static let AnalyticsEventPurchaseClick: String = "purchase_click"
    static let AnalyticsEventScanBarcode: String = "scan_barcode"
    
    // Custom Dimensions
    static let AnalyticsParameterAcidity: String = "acidity"
    static let AnalyticsParameterBarcode: String = "barcode"
    static let AnalyticsParameterBitterness: String = "bitterness"
    static let AnalyticsParameterBody: String = "body"
    static let AnalyticsParameterCapsuleAvailable: String = "capsule_available"
    static let AnalyticsParameterCapsuleId: String = "capsule_id"
    static let AnalyticsParameterCapsuleName: String = "capsule_name"
    static let AnalyticsParameterCupSize: String = "cup_size"
    static let AnalyticsParameterDecaffeinated: String = "decaffeinated"
    static let AnalyticsParameterIntensity: String = "intensity"
    static let AnalyticsParameterPurchaseLink: String = "purchase_link"
    static let AnalyticsParameterRegionCode: String = "region_code"
    static let AnalyticsParameterRoasting: String = "roasting"
    static let AnalyticsParameterScreenName: String =
        FirebaseAnalytics.AnalyticsParameterScreenName
    static let AnalyticsParameterScreenClass: String =
        FirebaseAnalytics.AnalyticsParameterScreenClass
    
    // Custom Metrics
    static let AnalyticsParameterCaffeine: String = "caffeine"
    static let AnalyticsParameterCapsulesRemaining: String = "capsules_remaining"
    static let AnalyticsParameterWater: String = "water"
}

extension Analytics {
    enum AnalyticsEvent {
        case addToCollection, addToFavourites, filter, logCoffee, purchaseClick, scanBarcode, search, view
    }
    
    private static func logAddToCollection(data: [String: Any]?) {
        if let data = data {
            FirebaseAnalytics.Analytics.logEvent(AnalyticsEventAddToCollection, parameters: data)
        }
    }
    
    private static func logAddToFavourites(data: [String: Any]?) {
        if let data = data {
            FirebaseAnalytics.Analytics.logEvent(AnalyticsEventAddToFavourites, parameters: data)
        }
    }
    
    private static func logCoffee(data: [String: Any]?) {
        if let data = data {
            FirebaseAnalytics.Analytics.logEvent(AnalyticsEventLogCoffee, parameters: data)
        }
    }
    
    private static func logFilter(data: [String: Any]?) {
        if let data = data {
            FirebaseAnalytics.Analytics.logEvent(AnalyticsEventFilter, parameters: data.compactMapValues { $0 })
        }
    }
    
    private static func logPurchaseClick(data: [String: Any]?) {
        if let data = data {
            FirebaseAnalytics.Analytics.logEvent(AnalyticsEventPurchaseClick, parameters: data)
        }
    }
    
    private static func logScanBarcode(data: [String: Any]?) {
        if let data = data {
            FirebaseAnalytics.Analytics.logEvent(AnalyticsEventScanBarcode, parameters: data)
        }
    }
    
    private static func logSearch(term: String?) {
        if let term = term {
            FirebaseAnalytics.Analytics.logEvent(AnalyticsEventSearch, parameters: [
                AnalyticsParameterSearchTerm: term
            ])
        }
    }
    
    private static func logView(data: [String: Any]?) {
        if let data = data {
            FirebaseAnalytics.Analytics.logEvent(AnalyticsEventScreenView, parameters: data)
        }
    }
}
