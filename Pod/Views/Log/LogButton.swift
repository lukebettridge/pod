//
//  LogButton.swift
//  Pod
//
//  Created by Luke Bettridge on 07/01/2021.
//

import SwiftUI

struct LogButton: View {
    let action: () -> Void
    let foregroundColor: Color
    let backgroundColor: Color
    let content: Text
    
    init(
        action: @escaping () -> Void,
        foregroundColor: Color = .white,
        backgroundColor: Color = .accentColor,
        @ViewBuilder content: () -> Text
    ) {
        self.action = action
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    
    var body: some View {
        Button(action: action) {
            content
                .foregroundColor(foregroundColor)
                .fontWeight(.medium)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(backgroundColor)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
