//
//  TrendsPopularLink.swift
//  Pod
//
//  Created by Luke Bettridge on 30/01/2021.
//

import SwiftUI

struct TrendsPopularLink: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Image(systemName: "number.square.fill")
                .font(.system(size: 35))
                .foregroundColor(colorScheme == .dark ? .primary : .accentColor)
            
            VStack(alignment: .leading, spacing: 2.5) {
                Text("Most Popular")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text("Top capsules of all time. Updated daily.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.forward")
                .font(Font.headline.weight(.light))
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(colorScheme == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
