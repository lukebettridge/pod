//
//  PodAmazon.swift
//  Pod
//
//  Created by Luke Bettridge on 13/01/2021.
//

import SwiftUI

struct PodAmazon: View {
    @Environment(\.openURL) var openURL
    let pod: Pod
    
    let regionCode: String? = Locale.current.regionCode
    
    private func log(_ purchaseLink: String) {
        Analytics.log(event: .purchaseClick, data: [
            Analytics.AnalyticsParameterCapsuleId: pod.id!,
            Analytics.AnalyticsParameterCapsuleName: pod.name!,
            Analytics.AnalyticsParameterPurchaseLink: purchaseLink,
            Analytics.AnalyticsParameterRegionCode: regionCode as Any
        ])
    }
    
    var body: some View {
        if let link = regionCode == "GB" ? pod.amazonLink : pod.amazonLinkUS {
            Button(action: {
                log(link)
                openURL(URL(string: link)!)
            }) {
                PodField {
                    VStack(alignment: .center, spacing: 5) {
                        Image(systemName: "cart")
                            .font(.title2)
                        Text("Purchase")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
