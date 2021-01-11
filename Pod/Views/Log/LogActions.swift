//
//  LogActions.swift
//  Pod
//
//  Created by Luke Bettridge on 07/01/2021.
//

import SwiftUI

struct LogActions: View {
    @Environment(\.colorScheme) var colorScheme
    let gp: GeometryProxy
    let cancel: () -> Void
    let log: () -> Void
    let disabled: Bool
    
    var body: some View {
        HStack {
            LogButton(
                action: cancel,
                foregroundColor: .primary,
                backgroundColor: Color(colorScheme == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground)
            ) {
                Text("Cancel")
            }
            LogButton(action: log) {
                Text("Log")
            }
            .disabled(disabled)
        }
        .padding()
        .background(
            VisualEffectView(effect: UIBlurEffect(style: .regular))
                .edgesIgnoringSafeArea(.bottom)
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color(UIColor.secondarySystemBackground)), alignment: .top)
        )
        .frame(height: 80)
        .offset(x: 0, y: gp.size.height / 2 - 40)
    }
}
