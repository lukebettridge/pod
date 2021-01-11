//
//  PodDescription.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodDescription: View {
    let description: String?
    
    var body: some View {
        if let description = description {
            PodField(header: "Description") {
                Text(description)
                    .font(.system(size: 14))
                    .lineSpacing(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct PodDescription_Previews: PreviewProvider {
    static var previews: some View {
        PodDescription(description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    }
}
