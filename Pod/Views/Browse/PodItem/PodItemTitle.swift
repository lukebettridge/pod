//
//  PodItemTitle.swift
//  Pod
//
//  Created by Luke Bettridge on 01/01/2021.
//

import SwiftUI

struct PodItemTitle: View {
    let pod: Pod
    let gp: GeometryProxy
    var color: Color { pod.color != nil ? Color(hex: pod.color!) : Color(UIColor.systemBackground) }
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                if let intensity = pod.intensity {
                    Text("\(intensity)")
                        .font(.system(size: min(gp.size.height, gp.size.width) * 0.9))
                        .fontWeight(.semibold)
                        .foregroundColor(color)
                        .brightness(-0.03)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                }
                VStack {
                    Image(uiImage: pod.image != nil ? UIImage(data: pod.image!)! : UIImage(named: "Placeholder")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: min(gp.size.height, gp.size.width) * 0.5,
                            height: min(gp.size.height, gp.size.width) * 0.5
                        )
                    
                    Text((pod.name ?? "").uppercased())
                        .font(.system(size: 45, weight: .bold, design: .serif))
                        .foregroundColor(Color(UIColor.systemBackground))
                        .multilineTextAlignment(.center)
                        .lineLimit((pod.name ?? "").contains(" ") ? 2 : 1)
                        .minimumScaleFactor(0.1)
                    
                    if let category = pod.category?.name {
                        Text(category)
                            .font(.system(size: 20))
                            .foregroundColor(Color(UIColor.systemBackground))
                            .italic()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
