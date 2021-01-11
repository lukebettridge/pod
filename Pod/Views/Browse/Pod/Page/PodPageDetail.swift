//
//  PodPageDetail.swift
//  Pod
//
//  Created by Luke Bettridge on 01/01/2021.
//

import SwiftUI

struct PodPageDetail: View {
    var pod: Pod
    var fetchRequest: FetchRequest<CollectionItem>
    
    private var collectionItem: Binding<CollectionItem?> {
        return Binding (
            get: { self.fetchRequest.wrappedValue.first },
            set: { _ in }
        )
    }
    
    init(pod: Pod) {
        self.pod = pod
        self.fetchRequest = FetchRequest(fetchRequest: CollectionItem.fetchRequest(podId: pod.id!))
    }
    
    var body: some View {
        VStack {
            Group {
                HStack(spacing: 10) {
                    PodCollection(collectionItem: collectionItem, podId: pod.id)
                    PodReport(name: pod.name)
                }
                PodFavourite(collectionItem: collectionItem)
                PodQuantity(collectionItem: collectionItem)
                PodNotes(collectionItem: collectionItem)
            }
            .foregroundColor(pod.color)
            .padding(.vertical, 2)
            
            Divider().padding(.vertical)
            
            PodTags(pod: pod)
            Group {
                HStack(spacing: 10) {
                    PodOrigin(origin: pod.origin)
                    PodIntensity(intensity: pod.intensity)
                }
                HStack(spacing: 10) {
                    PodPrice(price: pod.price)
                    PodIntroduced(introduced: pod.introduced)
                }
                PodProfile(notes: pod.notes, profile: pod.profile)
                PodRatings(ratings: pod.ratings, color: pod.color)
                PodDescription(description: pod.description)
                PodTip(tip: pod.tip)
                PodLink(link: pod.productLink)
            }
            .foregroundColor(pod.color)
            .padding(.vertical, 2)
        }
    }
}
