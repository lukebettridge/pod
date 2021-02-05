//
//  PodScale.swift
//  Pod
//
//  Created by Luke Bettridge on 04/01/2021.
//

import SwiftUI

struct PodScale: View {
    @Environment(\.colorScheme) var colorScheme
    
    let value: Int
    let color: Color?
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1..<6) { idx in
                Circle()
                    .fill(idx <= value ? color ?? Color.primary : Color(colorScheme == .dark ? UIColor.systemGray3 : UIColor.systemGray5))
                    .frame(width: 14, height: 14)
                Spacer()
            }
        }
        .padding(.vertical, 5)
    }
}
