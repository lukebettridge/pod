//
//  PodItemTag.swift
//  Pod
//
//  Created by Luke Bettridge on 02/01/2021.
//

import SwiftUI

struct PodItemTag: View {
    var text: String
    var color: Color?
    
    init (_ text: String, color: Color? = nil) {
        self.text = text
        self.color = color
    }
    
    var body: some View {
        HStack {
            if let color = color {
                Circle()
                    .stroke()
                    .fill(color)
                    .frame(width: 10, height: 10)
            }
            Text(text)
                .font(.system(size: 11, weight: .medium))
        }
        .padding(.vertical, 4.5)
        .padding(.horizontal, 8.5)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(UIColor.systemBackground))
        )
    }
}
