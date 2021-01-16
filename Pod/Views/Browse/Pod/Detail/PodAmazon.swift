//
//  PodAmazon.swift
//  Pod
//
//  Created by Luke Bettridge on 13/01/2021.
//

import SwiftUI

struct PodAmazon: View {
    @Environment(\.openURL) var openURL
    let link: String?
    let linkUS: String?
    
    let regionCode: String? = Locale.current.regionCode
    
    var body: some View {
        if let link = regionCode == "US" ? linkUS : link {
            Button(action: {
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

struct PodAmazon_Previews: PreviewProvider {
    static var previews: some View {
        PodAmazon(link: "https://nespresso.com/gb", linkUS: "https://nespresso.com/us")
    }
}
