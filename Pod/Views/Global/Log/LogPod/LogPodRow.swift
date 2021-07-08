//
//  LogPodRow.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct LogPodRow: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var pod: Pod
    var selected: Bool
    var disabled: Bool
    
    var body: some View {
        HStack {
            pod.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
                .frame(width: 32, height: 32)
                .background(Color.white)
                .clipShape(Circle())
            Text((pod.name ?? "").uppercased())
                .font(.custom("FSLucasPro-Bold", size: 13))
                .foregroundColor(selected ? .white : .primary)
                .opacity(disabled && !selected ? 0.2 : 1)
            Spacer()
        }
        .padding(5)
        .frame(width: 170)
        .background(selected ? Color.accentColor : Color("SecondaryBackground"))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor(pod.decaffeinated ? .red : .clear))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
