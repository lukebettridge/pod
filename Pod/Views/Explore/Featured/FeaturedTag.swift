//
//  FeaturedTag.swift
//  Pod
//
//  Created by Luke Bettridge on 03/02/2021.
//

import SwiftUI

struct FeaturedTag: View {
    let text: String?
    let backgroundColor: Color
    let foregroundColor: Color
    
    init(
        _ text: String?,
        backgroundColor: Color,
        foregroundColor: Color
    ) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        if let text = text {
            Text(text.uppercased())
                .font(.system(size: 10.5, weight: .bold))
                .foregroundColor(foregroundColor)
                .padding(.vertical, 3)
                .padding(.horizontal, 6)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 3))
        }
    }
}
