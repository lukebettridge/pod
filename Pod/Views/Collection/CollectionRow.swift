//
//  CollectionRow.swift
//  Pod
//
//  Created by Luke Bettridge on 26/12/2020.
//

import SwiftUI

struct CollectionRow: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var pod: Pod
    var collectionItem: CollectionItem
    var selectPod: (Pod) -> Void
    
    private func log() {
        Analytics.log(event: .addToFavourites, data: [
            Analytics.AnalyticsParameterCapsuleId: pod.id as Any,
            Analytics.AnalyticsParameterCapsuleName: pod.name as Any,
            Analytics.AnalyticsParameterCapsulesRemaining: collectionItem.quantity as Any
        ])
    }
    
    var body: some View {
        Button(action: { selectPod(pod) }) {
            HStack(spacing: 12.5) {
                pod.image
                    .resizable()
                    .background(pod.color)
                    .frame(width: 55, height: 55)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center, spacing: 5) {
                        Text((pod.name ?? "").uppercased())
                            .font(.custom("FSLucasPro-SemiBd", size: 16))
                            .foregroundColor(.primary)
                        if pod.decaffeinated {
                            Decaffeinated()
                                .padding(.bottom, 2)
                        }
                        if !collectionItem.notes.isEmpty {
                            Image(systemName: "note.text")
                                .font(.caption)
                                .padding(.top, -2)
                        }
                    }
                    
                    Text(pod.category?.name ?? pod.origin ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text("\(collectionItem.quantity) Capsules Remaining")
                        .font(.caption)
                        .foregroundColor(Color(UIColor.systemGray2))
                }
                
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .font(Font.headline.weight(.light))
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color.white
                )
        )
        .opacity(collectionItem.quantity > 0 ? 1 : 0.5)
        .contextMenu {
            Button(action: {
                collectionItem.favourite.toggle()
                collectionItem.save()
                if collectionItem.favourite { log() }
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }) {
                HStack {
                    Text(collectionItem.favourite ? "Unfavourite" : "Favourite")
                    Image(systemName: "star.\(collectionItem.favourite ? "slash" : "fill")")
                }
            }
            Button(action: {
                CollectionItem.remove(collectionItem: collectionItem)
                UIImpactFeedbackGenerator().impactOccurred()
            }) {
                HStack {
                    Text("Remove from Collection")
                    Image(systemName: "text.badge.minus")
                }
            }
        }
    }
}
