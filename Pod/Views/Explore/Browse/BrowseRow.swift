//
//  BrowseRow.swift
//  Pod
//
//  Created by Luke Bettridge on 31/01/2021.
//

import SwiftUI

struct BrowseRow: View {
    @EnvironmentObject var vm: ContentViewModel
    
    @ObservedObject var pod: Pod
    var subtitleType: Pod.SubtitleType
    var fetchRequest: FetchRequest<CollectionItem>
    
    var collectionItem: CollectionItem? {
        fetchRequest.wrappedValue.first
    }
    var subtitle: String {
        if subtitleType == .year, let introduced = pod.introduced {
            return String(introduced)
        } else if subtitleType == .category, let category = pod.category?.name {
            return String(category)
        }
        return pod.origin ?? ""
    }
    
    init(
        _ pod: Pod,
        subtitleType: Pod.SubtitleType = .origin
    ) {
        self.pod = pod
        self.subtitleType = subtitleType
        self.fetchRequest = FetchRequest(fetchRequest: CollectionItem.fetchRequest(podId: pod.id!))
    }
    
    func log(event: Analytics.AnalyticsEvent) {
        if (event == .addToCollection) {
            Analytics.log(event: .addToCollection, data: [
                Analytics.AnalyticsParameterCapsuleId: pod.id!,
                Analytics.AnalyticsParameterCapsuleName: pod.name!
            ])
        } else if (event == .addToFavourites) {
            Analytics.log(event: .addToFavourites, data: [
                Analytics.AnalyticsParameterCapsuleId: pod.id!,
                Analytics.AnalyticsParameterCapsuleName: pod.name!,
                Analytics.AnalyticsParameterCapsulesRemaining: collectionItem?.quantity as Any
            ])
        }
    }
    
    var body: some View {
        Button(action: { vm.openSheet(.pod, pod: pod) }) {
            VStack(alignment: .leading) {
                ZStack {
                    pod.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 125, height: 125)
                        .frame(width: 90, height: 90)
                    if collectionItem != nil {
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color(UIColor.systemGray3))
                                    .padding(.trailing, -10)
                            }
                            Spacer()
                        }
                    }
                }
                HStack {
                    Text((pod.name ?? "").uppercased())
                        .font(.custom("FSLucasPro-Bold", size: 12))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    if pod.decaffeinated {
                        Decaffeinated()
                            .padding(.bottom, 2)
                    }
                }
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .frame(width: 120)
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .contextMenu {
            if let collectionItem = collectionItem {
                Button(action: {
                    collectionItem.favourite.toggle()
                    collectionItem.save()
                    if collectionItem.favourite { log(event: .addToFavourites) }
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }) {
                    HStack {
                        Text(collectionItem.favourite ? "Unfavorite" : "Favorite")
                        Image(systemName: "star.\(collectionItem.favourite ? "slash" : "fill")")
                    }
                }
            }
            Button(action: {
                if let collectionItem = collectionItem {
                    CollectionItem.remove(collectionItem: collectionItem)
                } else if let id = pod.id {
                    CollectionItem.add(podId: id)
                    log(event: .addToCollection)
                }
                UIImpactFeedbackGenerator().impactOccurred(intensity: 1)
            }) {
                HStack {
                    Text("\(collectionItem != nil ? "Remove from" : "Add to") Collection")
                    Image(systemName: "text.badge.\(collectionItem != nil ? "minus" : "plus")")
                }
            }
        }
    }
}
