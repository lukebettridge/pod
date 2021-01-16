//
//  PodPrice.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodPrice: View {
    let price: Double?
    let priceUS: Double?
    
    let regionCode: String? = Locale.current.regionCode
    
    var body: some View {
        if regionCode == "US" {
            if let price = priceUS {
                PodField(header: "Price") {
                    Text(String(format: "$%.02f", price))
                }
            }
        } else {
            if let price = price {
                PodField(header: "Price") {
                    Text(String(format: "£%.02f", price))
                }
            }
        }
    }
}

struct PodPrice_Previews: PreviewProvider {
    static var previews: some View {
        PodPrice(price: 0.35, priceUS: 0.7)
    }
}
