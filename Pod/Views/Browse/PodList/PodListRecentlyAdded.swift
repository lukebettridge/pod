//
//  PodListRecentlyAdded.swift
//  Pod
//
//  Created by Luke Bettridge on 19/01/2021.
//

import SwiftUI

struct PodListRecentlyAdded: View {
    @Binding var pods: [Pod]
    @Binding var selectedPod: Pod?
    
    var filteredPods: [Pod] {
        pods.filter { $0.created > Calendar.current.date(byAdding: .day, value: -7, to: Date())! }
    }
    
    var body: some View {
        if !filteredPods.isEmpty {
            VStack {
                Section(
                    header:
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Recently Added".uppercased())
                                .font(.custom("FSLucasPro-Bold", size: 18))
                            Text("A list of capsules added to Pod in the last week.")
                                .font(.caption)
                                .foregroundColor(Color.gray)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding(.bottom, 5)
                        .padding(.horizontal)
                ) {
                    PodListGrid(
                        pods: filteredPods,
                        selectPod: { pod in selectedPod = pod },
                        preferredSubtitle: .category,
                        rows: 1
                    )
                }
                Divider()
                    .padding(.top, 9)
                    .padding(.horizontal)
            }
        }
    }
}
