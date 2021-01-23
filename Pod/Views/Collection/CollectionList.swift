//
//  CollectionList.swift
//  Pod
//
//  Created by Luke Bettridge on 26/12/2020.
//

import SwiftUI

struct CollectionList: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var pods: [Pod]
    var collectionItems: FetchedResults<CollectionItem>
    var selectPod: (Pod) -> Void
    
    @State private var isShowingEditView: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                CollectionFavourites(
                    pods: $pods,
                    selectPod: selectPod,
                    showEditView: { isShowingEditView.toggle() },
                    collectionItems: collectionItems
                )
                
                Divider()
                    .padding(.vertical)
                
                ForEach (collectionItems.filter { !$0.favourite }) { collectionItem in
                    if let pod = pods.first(where: { $0.id == collectionItem.podId }) {
                        CollectionRow(
                            pod: pod,
                            collectionItem: collectionItem,
                            selectPod: selectPod
                        )
                    }
                }
                
                Text("You have \(collectionItems.reduce(0) { $0 + $1.quantity }) capsules in your collection.")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.top, 4)
            }
            .padding()
            .padding(.bottom, 30)
        }
        .background(
            Color(colorScheme == .dark ? UIColor.systemBackground : UIColor.secondarySystemBackground)
                .edgesIgnoringSafeArea(.all)
        )
        .sheet(isPresented: $isShowingEditView) {
            EditFavourites(
                pods: $pods,
                collectionItems: collectionItems,
                exit: { isShowingEditView.toggle() }
            )
            .environment(\.managedObjectContext, managedObjectContext)
        }
    }
}
