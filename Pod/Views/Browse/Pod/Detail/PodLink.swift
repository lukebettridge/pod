//
//  PodLink.swift
//  Pod
//
//  Created by Luke Bettridge on 08/01/2021.
//

import SwiftUI

struct PodLink: View {
    @Environment(\.openURL) var openURL
    let link: String?
    let linkUS: String?
    
    let regionCode: String? = Locale.current.regionCode
    
    var body: some View {
        if let link = regionCode == "GB" ? link : linkUS {
            Button(action: {
                openURL(URL(string: link)!)
            }) {
                PodField {
                    VStack(alignment: .center, spacing: 5) {
                        Image(systemName: "arrow.up.forward.square")
                            .font(.title2)
                        Text("Product Page")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct PodLink_Previews: PreviewProvider {
    static var previews: some View {
        PodLink(link: "https://nespresso.com/gb", linkUS: "https://nespresso.com/us")
    }
}
