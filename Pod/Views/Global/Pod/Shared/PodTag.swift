//
//  PodTag.swift
//  Pod
//
//  Created by Luke Bettridge on 02/01/2021.
//

import SwiftUI

struct PodTag: View {
    @Environment(\.colorScheme) var colorScheme
    var text: String
    var color: Color?
    var icon: String?
    
    init (_ text: String, color: Color? = nil, icon: String? = nil) {
        self.text = text
        self.color = color
        self.icon = icon
    }
    
    var body: some View {
        HStack(spacing: 4) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 12, weight: .bold))
                    .padding(.bottom, 1)
            }
            Text(text.uppercased())
                .font(.custom("FSLucasPro-Bold", size: 12))
        }
        .foregroundColor(color ?? .primary)
        .padding(.top, 3)
        .padding(.bottom, 2)
        .padding(.leading, 4)
        .padding(.trailing, 8)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(colorScheme == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground))
        )
    }
}
