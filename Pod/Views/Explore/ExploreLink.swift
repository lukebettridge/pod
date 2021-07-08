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
                .foregroundColor(.accentColor)
            
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
                .font(Font.subheadline.weight(.light))
                .foregroundColor(.accentColor)
        }
        .padding()
        .background(Color("SecondaryBackground"))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
