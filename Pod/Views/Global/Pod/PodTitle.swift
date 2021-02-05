//
//  PodTitle.swift
//  Pod
//
//  Created by Luke Bettridge on 01/01/2021.
//

import SwiftUI

struct PodTitle: View {
    @Environment(\.colorScheme) var colorScheme
    
    let pod: Pod
    let gp: GeometryProxy
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                if let intensity = pod.intensity {
                    Text("\(intensity)")
                        .font(.custom("FSLucasPro-Bold", size: gp.size.width))
                        .foregroundColor(colorScheme == .dark ? Color(UIColor.systemBackground) : pod.color)
                        .brightness(-0.03)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .frame(height: gp.size.height * 0.45)
                }
                VStack {
                    pod.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: min(gp.size.height, gp.size.width) * 0.5,
                            height: min(gp.size.height, gp.size.width) * 0.5
                        )
                    
                    Group {
                        Text((pod.name ?? "").uppercased())
                            .font(.custom("FSLucasPro-Bold", size: 50))
                            .lineLimit((pod.name ?? "").contains(" ") ? 2 : 1)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.1)
                        
                        if let category = pod.category?.name {
                            Text(category.uppercased())
                                .font(.custom("FSLucasPro-SemiBd", size: 20))
                        }
                    }
                    .foregroundColor(colorScheme == .dark ? pod.color : Color(UIColor.systemBackground))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 20)
        
    }
}
