//
//  FilterCupRow.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import SwiftUI

struct FilterCupRow: View {
    @Environment(\.colorScheme) var colorScheme
    let cup: String
    let selected: Bool
    let disabled: Bool = false
    
    var body: some View {
        VStack(spacing: 5) {
            Image(cup)
                .resizable()
                .scaledToFit()
                .frame(height: 18)
            Text(cup)
                .font(.system(size: 8))
                .lineLimit(cup.contains(" ") ? 2 : 1)
                .minimumScaleFactor(0.1)
                .multilineTextAlignment(.center)
                .frame(height: 16)
        }
        .foregroundColor(selected ? .white : colorScheme == .dark ? .primary : .gray)
        .opacity(disabled && !selected ? colorScheme == .dark ? 0.2 : 0.4 : 1)
        .padding(.top, 7)
        .padding(.horizontal, 10)
        .frame(width: 65, height: 60)
        .background(selected ? Color.accentColor : Color(colorScheme == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground))
    }
}
