//
//  CollectionFavourites.swift
//  Pod
//
//  Created by Luke Bettridge on 04/01/2021.
//

import SwiftUI

struct CollectionFavourites: View {
    @Binding var pods: [Pod]
    var selectPod: (Pod) -> Void
    var showEditView: () -> Void
    var collectionItems: FetchedResults<CollectionItem>
    
    var filteredCollectionItems: [FetchedResults<CollectionItem>.Element] {
        collectionItems.filter { $0.favourite }
    }
    
    var body: some View {
        Section(header: HStack {
            Text("Favourites").font(.title2).fontWeight(.semibold)
            Spacer()
            Button(action: showEditView) {
                Text("Edit").fontWeight(.regular)
            }
        }) {
            if filteredCollectionItems.count > 0 {
                ForEach (filteredCollectionItems) { collectionItem in
                    if let pod = pods.first(where: { $0.id ?? "" == collectionItem.podId }) {
                        CollectionRow(
                            pod: pod,
                            collectionItem: collectionItem,
                            selectPod: selectPod
                        )
                    }
                }
            } else {
                FavouritesEmpty()
            }
        }
    }
}
