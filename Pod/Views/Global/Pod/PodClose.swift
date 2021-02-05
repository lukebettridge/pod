//
//  PodClose.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodClose: View {
    @Environment(\.colorScheme) var colorScheme
    
    let exit: () -> Void
    let color: Color
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: { exit() }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(colorScheme == .dark ? color : Color(UIColor.systemBackground))
            }
        }
    }
}
