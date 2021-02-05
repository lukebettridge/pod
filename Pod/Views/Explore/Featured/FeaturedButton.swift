//
//  FeaturedButton.swift
//  Pod
//
//  Created by Luke Bettridge on 03/02/2021.
//

import SwiftUI

struct FeaturedButton: View {
    let action: () -> Void
    let backgroundColor: Color
    let foregroundColor: Color
    
    var body: some View {
        Button(action: action) {
            Text("Show more")
                .font(.subheadline)
                .foregroundColor(backgroundColor)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(foregroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 7.5))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
