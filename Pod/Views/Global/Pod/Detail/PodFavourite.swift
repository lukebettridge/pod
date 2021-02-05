//
//  PodFavourite.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodFavourite: View {
    @Binding var collectionItem: CollectionItem?
    let pod: Pod
    
    func log() {
        Analytics.log(event: .addToFavourites, data: [
            Analytics.AnalyticsParameterCapsuleId: pod.id!,
            Analytics.AnalyticsParameterCapsuleName: pod.name!,
            Analytics.AnalyticsParameterCapsulesRemaining: collectionItem?.quantity as Any
        ])
    }
    
    var body: some View {
        if let collectionItem = collectionItem {
            Button(action: {
                collectionItem.favourite.toggle()
                collectionItem.save()
                if collectionItem.favourite { log() }
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }) {
                PodField {
                    VStack(alignment: .center, spacing: 5) {
                        Image(systemName: collectionItem.favourite ? "star.slash.fill" : "star")
                            .font(.title2)
                        Text(collectionItem.favourite ? "Unfavorite" : "Favorite")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
