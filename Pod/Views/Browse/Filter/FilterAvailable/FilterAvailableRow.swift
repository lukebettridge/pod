//
//  FilterAvailableRow.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import SwiftUI

struct FilterAvailableRow: View {
    @Environment(\.colorScheme) var colorScheme
    let option: String
    let selected: Bool
    
    var body: some View {
        Text(option)
            .font(.subheadline)
            .foregroundColor(selected ? .white : colorScheme == .dark ? .primary : .gray)
            .frame(width: 114, height: 40)
            .background(selected ? Color.accentColor : Color(colorScheme == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground))
    }
}
