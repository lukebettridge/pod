//
//  CollectionRow.swift
//  Pod
//
//  Created by Luke Bettridge on 26/12/2020.
//

import SwiftUI

struct CollectionRow: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: ContentViewModel
    
    @ObservedObject var collectionItem: CollectionItem
    @ObservedObject var pod: Pod
    
    init(_ collectionItem: CollectionItem, pod: Pod) {
        self.collectionItem = collectionItem
        self.pod = pod
    }
    
    private func log() {
        Analytics.log(event: .addToFavourites, data: [
            Analytics.AnalyticsParameterCapsuleId: pod.id!,
            Analytics.AnalyticsParameterCapsuleName: pod.name!,
            Analytics.AnalyticsParameterCapsulesRemaining: collectionItem.quantity as Any
        ])
    }
    
    var body: some View {
        Button(action: { vm.openSheet(.pod, pod: pod) }) {
            HStack(spacing: 12.5) {
                pod.image
                    .resizable()
                    .background(pod.color)
                    .frame(width: 55, height: 55)
                    .clipShape(RoundedRectangle(cornerRadius: 12.5))
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center, spacing: 5) {
                        Text((pod.name ?? "").uppercased())
                            .font(.custom("FSLucasPro-SemiBd", size: 16))
                            .foregroundColor(.primary)
                            .lineLimit(1)
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
                    .font(Font.subheadline.weight(.light))
                    .foregroundColor(.accentColor)
            }
        }
        .padding(.horizontal, 13.5)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("SecondaryBackground"))
        )
        .opacity(collectionItem.quantity > 0 ? 1 : 0.5)
        .contextMenu {
            Button(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.linear(duration: 0.25)) {
                        collectionItem.favourite.toggle()
                        collectionItem.save()
                        if collectionItem.favourite { log() }
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
                }
            }) {
                HStack {
                    Text(collectionItem.favourite ? "Unfavorite" : "Favorite")
                    Image(systemName: "star.\(collectionItem.favourite ? "slash" : "fill")")
                }
            }
            Button(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.linear(duration: 0.25)) {
                        CollectionItem.remove(collectionItem: collectionItem)
                        UIImpactFeedbackGenerator().impactOccurred()
                    }
                }
            }) {
                HStack {
                    Text("Remove from Collection")
                    Image(systemName: "text.badge.minus")
                }
            }
        }
    }
}
