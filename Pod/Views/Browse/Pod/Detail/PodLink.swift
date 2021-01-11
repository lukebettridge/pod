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
    
    var body: some View {
        if let link = link {
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
        PodLink(link: "https://nespresso.com/")
    }
}
