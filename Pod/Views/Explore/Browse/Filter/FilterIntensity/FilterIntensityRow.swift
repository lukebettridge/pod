//
//  FilterIntensityRow.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import SwiftUI

struct FilterIntensityRow: View {
    @Environment(\.colorScheme) var colorScheme
    let intensity: Int
    let selected: Bool
    let disabled: Bool = false
    
    var body: some View {
        VStack {
            Text("\(intensity)")
        }
        .foregroundColor(selected ? .white : colorScheme == .dark ? .primary : .gray)
        .opacity(disabled && !selected ? colorScheme == .dark ? 0.2 : 0.4 : 1)
        .frame(width: 45, height: 45)
        .background(selected ? Color.accentColor : Color(colorScheme == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground))
    }
}
