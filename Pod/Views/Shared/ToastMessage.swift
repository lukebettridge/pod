//
//  ToastMessage.swift
//  Pod
//
//  Created by Luke Bettridge on 01/01/2021.
//

import SwiftUI

struct ToastMessage<Content: View>: View {
    let foregroundColor: Color?
    let content: Content
    
    init(foregroundColor: Color? = nil, @ViewBuilder content: () -> Content) {
        self.foregroundColor = foregroundColor
        self.content = content()
    }
    
    var body: some View {
        content
            .font(Font.title3.weight(.semibold))
            .foregroundColor(foregroundColor)
            .padding()
            .background(
                VisualEffectView(effect: UIBlurEffect(style: .regular))
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
