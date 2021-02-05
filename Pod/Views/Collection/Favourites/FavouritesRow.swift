//
//  FavouritesRow.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct FavouritesRow: View {
    @ObservedObject var collectionItem: CollectionItem
    let pod: Pod
    
    var body: some View {
        HStack(spacing: 10) {
            pod.image
                .resizable()
                .background(pod.color)
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            HStack(spacing: 5) {
            Text((pod.name ?? "").uppercased())
                .font(.custom("FSLucasPro-SemiBd", size: 16))
                .lineLimit(1)
                if pod.decaffeinated {
                    Decaffeinated()
                        .padding(.bottom, 1)
                }
            }
            Spacer()
            Button(action: {
                collectionItem.favourite.toggle()
                collectionItem.save()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }) {
                Image(systemName: collectionItem.favourite ? "star.fill" : "star")
                    .foregroundColor(Color.accentColor)
            }
        }
        .padding(.vertical, 2.5)
    }
}
