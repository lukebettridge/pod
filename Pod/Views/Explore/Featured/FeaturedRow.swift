//
//  FeaturedRow.swift
//  Pod
//
//  Created by Luke Bettridge on 02/02/2021.
//

import SwiftUI

struct FeaturedRow: View {
    @EnvironmentObject var vm: ContentViewModel

    @ObservedObject var pod: Pod
    var color: Color
    
    init(_ pod: Pod, color: Color) {
        self.pod = pod
        self.color = color
    }
    
    var body: some View {
        Button(action: { vm.openSheet(.pod, pod: pod) }) {
            VStack {
                pod.image
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .scaleEffect(1.3)
                HStack {
                    Text((pod.name ?? "").uppercased())
                        .font(.custom("FSLucasPro-Bold", size: 12))
                        .foregroundColor(color)
                        .lineLimit(1)
                    if pod.decaffeinated {
                        Decaffeinated()
                            .padding(.bottom, 2)
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

