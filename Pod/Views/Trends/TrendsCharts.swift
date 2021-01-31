//
//  TrendsCharts.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import SwiftUI

struct TrendsCharts: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "chart.bar.xaxis")
                .font(.system(size: 35))
                .foregroundColor(colorScheme == .dark ? .primary : .accentColor)
            VStack(alignment: .leading, spacing: 5) {
                Text("Trends by Chart")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text("See your caffeine intake, cup choice, and capsule usage over time.")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
                Text("Coming Soon")
                    .font(.caption2)
                    .foregroundColor(Color(UIColor.systemGray2))
            }
            Spacer()
        }
        .background(Color(colorScheme == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct TrendsCharts_Previews: PreviewProvider {
    static var previews: some View {
        TrendsCharts()
    }
}
