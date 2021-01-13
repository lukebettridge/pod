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
    var isLimitedEdition: Bool = false

    var sortedPods: [Pod] {
        !isLimitedEdition ? pods : pods.sorted { $0.introduced ?? 0 > $1.introduced ?? 0 }
    }
    var gridItem = GridItem(.fixed(125), spacing: 20)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if pods.count > 0 {
                LazyHGrid(
                    rows: pods.count > 6 ? [gridItem, gridItem] : [gridItem],
                    spacing: -5
                ) {
                    ForEach(sortedPods) { pod in
                        PodListGridItem(pod: pod, selectPod: selectPod)
                    }
                }
            }
        }
    }
}
