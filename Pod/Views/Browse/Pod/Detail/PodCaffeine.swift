//
//  PodCaffeine.swift
//  Pod
//
//  Created by Luke Bettridge on 11/01/2021.
//

import SwiftUI

struct PodCaffeine: View {
    let pod: Pod
    
    var caffeine: Double {
        pod.caffeinePerML * (Pod.cupVolumes[pod.cupSize.first ?? ""] ?? 40)
    }
    
    var body: some View {
        PodField(header: "Caffeine") {
            HStack(alignment: .lastTextBaseline, spacing: 3.5) {
                Text(String(format: caffeine == floor(caffeine) ? "%.0f" : "%.1f", caffeine))
                Text("mg")
                    .font(.caption2)
                    .foregroundColor(Color(UIColor.systemGray2))
                Text("/")
                Text(String(format: "%.0f", Pod.cupVolumes[pod.cupSize.first ?? ""] ?? 40))
                Text("ml")
                    .font(.caption2)
                    .foregroundColor(Color(UIColor.systemGray2))
            }
        }
    }
}
