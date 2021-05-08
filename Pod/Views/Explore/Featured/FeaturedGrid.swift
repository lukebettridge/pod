//
//  FeaturedGrid.swift
//  Pod
//
//  Created by Luke Bettridge on 02/02/2021.
//

import SwiftUI

struct FeaturedGrid: View {
    @Environment(\.pods) var pods
    let color: Color
    
    let gridItem = GridItem(.flexible(minimum: 0, maximum: 100), spacing: 15)
    
    var body: some View {
        LazyVGrid(
            columns: Array(
                repeating: gridItem,
                count: min(pods.count, 3)
            ),
            alignment: .center,
            spacing: 15
        ) {
            ForEach(pods) { pod in
                FeaturedRow(pod, color: color)
            }
        }
    }
}
