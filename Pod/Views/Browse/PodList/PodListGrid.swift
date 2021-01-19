//
//  PodListGrid.swift
//  Pod
//
//  Created by Luke Bettridge on 30/12/2020.
//

import SwiftUI

struct PodListGrid: View {
    var pods: [Pod]
    var selectPod: (Pod) -> Void
    var preferredSubtitle: Pod.SubtitleType = .origin
    var rows: Int?

    var sortedPods: [Pod] {
        if preferredSubtitle == .year {
            return pods.sorted { $0.introduced ?? 0 > $1.introduced ?? 0 }
        } else if preferredSubtitle == .category {
            return pods.sorted { $0.created > $1.created }
        }
        return pods
    }
    var gridItem = GridItem(.fixed(125), spacing: 20)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if pods.count > 0 {
                LazyHGrid(
                    rows: Array(
                        repeating: gridItem,
                        count: rows ?? (pods.count > 6 ? 2 : 1)
                    ),
                    spacing: -5
                ) {
                    ForEach(sortedPods) { pod in
                        PodListGridItem(
                            pod: pod,
                            selectPod: selectPod,
                            preferredSubtitle: preferredSubtitle
                        )
                    }
                }
            }
        }
    }
}
