//
//  ExploreLink.swift
//  Pod
//
//  Created by Luke Bettridge on 03/02/2021.
//

import SwiftUI

struct ExploreLink: View {
    @Environment(\.colorScheme) var colorScheme
    
    let icon: String
    let title: String
    let subtitle: String?
    
    init(
        icon: String,
        title: String,
        subtitle: String? = nil
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 35))
                .foregroundColor(colorScheme == .dark ? .primary : .accentColor)
            
            VStack(alignment: .leading, spacing: 2.5) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
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
