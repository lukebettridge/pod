//
//  LogPod.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct LogPod: View {
    @Binding var selected: Pod?
    var pods: [Pod]
    var collectionItems: FetchedResults<CollectionItem>
    
    @State var alertPod: Pod?
    var gridItem = GridItem(.fixed(40), spacing: 7.5)
    
    var body: some View {
        Section(
            header:
                HStack {
                    Text("Capsule")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    if selected != nil {
                        Button(action: { selected = nil }) {
                            Text("Clear All").fontWeight(.regular)
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal)
        ) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(
                    rows:
                        Array(
                            repeating: gridItem,
                            count: min(Int((Double(collectionItems.count) / 3.0).rounded(.up)), 4)
                        ),
                    spacing: 10
                ) {
                    ForEach (collectionItems) { collectionItem in
                        if let pod = pods.first(where: { $0.id ?? "" == collectionItem.podId }) {
                            LogPodRow(
                                pod: pod,
                                selected: selected?.id! == pod.id!,
                                disabled: collectionItem.quantity == 0
                            )
                            .onTapGesture {
                                if selected?.id! != pod.id! {
                                    if collectionItem.quantity > 0 {
                                        selected = pod
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    } else {
                                        alertPod = pod
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .alert(item: $alertPod) { pod in
                Alert(
                    title: Text("Select \(pod.name ?? "Capsule")"),
                    message: Text("You have 0 \(pod.name ?? "of these") capsules remaining, would you like to select this capsule anyway?"),
                    primaryButton: .default(Text("Select")) {
                        selected = pod
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

