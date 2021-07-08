//
//  FilterRatingRow.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import SwiftUI

struct FilterRatingRow: View {
    @Environment(\.colorScheme) var colorScheme
    let rating: Int
    let selected: Bool
    let disabled: Bool = false
    
    var body: some View {
        VStack {
            Text("\(rating)")
        }
        .foregroundColor(selected ? .white : colorScheme == .dark ? .primary : .gray)
        .opacity(disabled && !selected ? colorScheme == .dark ? 0.2 : 0.4 : 1)
        .frame(width: 45, height: 45)
        .background(selected ? Color.accentColor : Color("SecondaryBackground"))
    }
}
