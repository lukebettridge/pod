//
//  PodDetail.swift
//  Pod
//
//  Created by Luke Bettridge on 01/01/2021.
//

import SwiftUI

struct PodDetail: View {
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
                    PodCollection(collectionItem: collectionItem, pod: pod)
                    PodReport(name: pod.name)
                }
                HStack(spacing: 10) {
                    PodFavourite(collectionItem: collectionItem, pod: pod)
                    PodAmazon(pod: pod)
                }
                PodQuantity(collectionItem: collectionItem)
                PodNotes(collectionItem: collectionItem)
            }
            .foregroundColor(pod.color)
            .padding(.vertical, 2)
            
            Divider().padding(.vertical)
            
            PodTags(pod: pod)
            Group {
                PodOrigin(origin: pod.origin)
                HStack(spacing: 10) {
                    PodCaffeine(pod: pod)
                    PodIntensity(intensity: pod.intensity)
                }
                HStack(spacing: 10) {
                    PodPrice(price: pod.price, priceUS: pod.priceUS)
                    PodIntroduced(introduced: pod.introduced)
                }
                PodProfile(notes: pod.notes, profile: pod.profile)
                PodRatings(ratings: pod.ratings, color: pod.color)
                PodDescription(description: pod.description)
                PodTip(tip: pod.tip)
                PodLink(link: pod.productLink, linkUS: pod.productLinkUS)
            }
            .foregroundColor(pod.color)
            .padding(.vertical, 2)
        }
    }
}
