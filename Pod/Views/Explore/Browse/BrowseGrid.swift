//
//  BrowseGrid.swift
//  Pod
//
//  Created by Luke Bettridge on 31/01/2021.
//

import SwiftUI

struct BrowseGrid: View {
    @Environment(\.pods) var pods
    var subtitleType: Pod.SubtitleType = .origin
    var rows: Int? = nil
    
    var sortedPods: [Pod] {
        switch subtitleType {
            case .category:
                return pods.sorted { $0.created > $1.created }
            case .year:
                return pods.sorted { $0.introduced ?? 0 > $1.introduced ?? 0 }
            default:
                return pods
        }
    }
    let gridItem = GridItem(.fixed(125), spacing: 20)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(
                rows: Array(
                    repeating: gridItem,
                    count: rows ?? (pods.count > 6 ? 2 : 1)
                ),
                spacing: -5
            ) {
                ForEach(sortedPods) { pod in
                    BrowseRow(pod, subtitleType: subtitleType)
                }
            }
        }
    }
}
