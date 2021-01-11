//
//  PodFavourite.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodFavourite: View {
    @Binding var collectionItem: CollectionItem?
    
    var body: some View {
        if let collectionItem = collectionItem {
            Button(action: {
                collectionItem.favourite.toggle()
                collectionItem.save()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }) {
                PodField {
                    VStack(alignment: .center, spacing: 5) {
                        Image(systemName: collectionItem.favourite ? "star.slash.fill" : "star")
                            .font(.title2)
                        Text(collectionItem.favourite ? "Unfavourite" : "Favourite")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct PodFavourite_Previews: PreviewProvider {
    private static var collectionItem: Binding<CollectionItem?> {
        Binding (
            get: { Optional(CollectionItem()) },
            set: { _ in }
        )
    }
    
    static var previews: some View {
        PodFavourite(collectionItem: collectionItem)
    }
}
