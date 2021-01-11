//
//  PodPrice.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodPrice: View {
    let price: Double?
    
    var body: some View {
        if let price = price {
            PodField(header: "Price") {
                Text(String(format: "£%.02f", price))
            }
        }
    }
}

struct PodPrice_Previews: PreviewProvider {
    static var previews: some View {
        PodPrice(price: 0.34)
    }
}
