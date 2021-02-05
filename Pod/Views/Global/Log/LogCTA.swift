//
//  LogCTA.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI
import Introspect

struct LogCTA: View {
    @Environment(\.colorScheme) var colorScheme
    @State var tabBarHeight: CGFloat = 0
    
    let action: () -> Void
    let gp: GeometryProxy
    
    var bottomOffset: CGFloat { UIDevice.current.hasNotch ? 35 : 10 }
    var relativeWidth: CGFloat { gp.size.width / 5.5 }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground).opacity(0.0001)
                .frame(width: relativeWidth * 1.1, height: tabBarHeight)
                .offset(x: 0, y: (relativeWidth - tabBarHeight) / 2 + bottomOffset)
            Button(action: action) {
                Image("Espresso")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.white.opacity(colorScheme == .dark ? 0.5 : 1))
                    .frame(width: relativeWidth / 2.25, height: relativeWidth / 2.25)
                    .frame(width: relativeWidth, height: relativeWidth)
                    .background(
                        Circle()
                            .fill(
                                colorScheme == .dark ? Color(UIColor.tertiarySystemBackground) : Color.accentColor
                            )
                    )
                    .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.3 : 0.1), radius: 6, x: 0, y: 0)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .offset(x: 0, y: gp.size.height / 2 - relativeWidth / 2 - bottomOffset)
        .introspectTabBarController { UITabBarController in
            tabBarHeight = UITabBarController.tabBar.bounds.height
        }
    }
}
