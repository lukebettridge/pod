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

    var gridItem = GridItem(.fixed(125), spacing: 20)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(
                rows: pods.count > 6 ? [gridItem, gridItem] : [gridItem],
                spacing: -5
            ) {
                ForEach(pods) { pod in
                    PodListGridItem(pod: pod, selectPod: selectPod)
                }
            }
        }
    }
}
