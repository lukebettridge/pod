//
//  PodIntensity.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodIntensity: View {
    let intensity: Int?
    
    var body: some View {
        if let intensity = intensity {
            PodField(header: "Intensity") {
                HStack(alignment: .center, spacing: 3.5) {
                    Text("\(intensity)")
                    Text("/13")
                        .font(.caption2)
                        .foregroundColor(Color(UIColor.systemGray2))
                }
            }
        }
    }
}

struct PodIntensity_Previews: PreviewProvider {
    static var previews: some View {
        PodIntensity(intensity: 11)
    }
}
