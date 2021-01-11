//
//  PodField.swift
//  Pod
//
//  Created by Luke Bettridge on 31/12/2020.
//

import SwiftUI

struct PodField<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    
    let header: String?
    let content: Content
    
    init(header: String? = nil, @ViewBuilder content: () -> Content) {
        self.header = header
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3.5) {
            if let header = header {
                Text(header)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            content
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12.5)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(Color(colorScheme == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
