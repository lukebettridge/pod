//
//  Featured.swift
//  Pod
//
//  Created by Luke Bettridge on 02/02/2021.
//

import SwiftUI
import Combine

struct Featured: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.pods) var pods
    
    @State var isOpen = false
    
    @ObservedObject var featuredConfig: FeaturedConfig =
        FeaturedConfig(RemoteConfig.config.jsonValue(forKey: .featured) as? [String: Any] ?? [:])
    
    var backgroundColor: Color {
        colorScheme == .dark
            ? Color(UIColor.secondarySystemBackground)
            : featuredConfig.backgroundColor ?? Color(UIColor.systemBackground)
    }
    
    var backgroundImage: Image? {
        featuredConfig.backgroundImage[colorScheme]
    }
    
    var foregroundColor: Color {
        featuredConfig.foregroundColor[colorScheme] ?? .white
    }
    
    var filteredPods: [Pod] {
        (featuredConfig.podIds ?? []).compactMap { id in pods.first(where: { $0.id == id })}
    }
    
    var slicedPods: [Pod] {
        isOpen ? filteredPods : Array(filteredPods.prefix(3))
    }
    
    var body: some View {
        if let title = featuredConfig.title {
            VStack {
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        FeaturedTag(
                            featuredConfig.tag,
                            backgroundColor: foregroundColor,
                            foregroundColor: backgroundColor
                        )
                        Group {
                            Text(title.uppercased())
                                .font(.custom("FSLucasPro-Bold", size: 30))
                            if let subtitle = featuredConfig.subtitle {
                                Text(subtitle)
                                    .font(.system(size: 14, weight: .medium))
                            }
                        }
                        .foregroundColor(foregroundColor)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.1)
                    }
                    
                    FeaturedGrid(color: foregroundColor)
                        .environment(\.pods, slicedPods)
                    
                    if !isOpen && filteredPods.count > 3 {
                        FeaturedButton(
                            action: {
                                withAnimation {
                                    isOpen.toggle()
                                }
                            },
                            backgroundColor: backgroundColor,
                            foregroundColor: foregroundColor
                        )
                    }
                }
                .padding(.vertical, 25)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(
                    backgroundImage?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Divider()
                    .padding(.vertical)
            }
            .onAppear {
                isOpen = false
            }
        }
    }
}
