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
    var selectPod: (Pod) -> Void
    var collectionItems: FetchedResults<CollectionItem>
    
    @State private var isShowingEditView: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                CollectionFavourites(
                    pods: $pods,
                    selectPod: selectPod,
                    showEditView: { isShowingEditView.toggle() },
                    collectionItems: collectionItems
                )
                
                Spacer()
                
                ForEach (collectionItems.filter { !$0.favourite }) { collectionItem in
                    if let pod = pods.first(where: { $0.id ?? "" == collectionItem.podId }) {
                        CollectionRow(
                            pod: pod,
                            collectionItem: collectionItem,
                            selectPod: selectPod
                        )
                    }
                }
            }
            .padding()
        }
        .background(
            Color(colorScheme == .dark ? UIColor.systemBackground : UIColor.secondarySystemBackground)
                .edgesIgnoringSafeArea(.all)
        )
        .sheet(isPresented: $isShowingEditView) {
            CollectionEdit(
                pods: $pods,
                collectionItems: collectionItems,
                exit: { isShowingEditView.toggle() }
            )
            .environment(\.managedObjectContext, managedObjectContext)
        }
    }
}
