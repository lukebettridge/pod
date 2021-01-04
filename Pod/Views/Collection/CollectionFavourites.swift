//
//  CollectionFavourites.swift
//  Pod
//
//  Created by Luke Bettridge on 04/01/2021.
//

import SwiftUI

struct CollectionFavourites: View {
    @Environment(\.colorScheme) var colorScheme
    
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
                VStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .font(Font.system(size: 45).weight(.light))
                        .foregroundColor(Color(UIColor.systemGray5))
                        .padding(.bottom, 5)
                    Text("You have no favourites.")
                        .font(.headline)
                        .fontWeight(.medium)
                    Text("Find your pods in the Browse tab, press \(Image(systemName: "star")) to add them to your favourites.")
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .foregroundColor(Color(UIColor.systemGray3))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.top, 18.5)
                .padding(.bottom, 21)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color.white
                        )
                )
            }
        }
    }
}
