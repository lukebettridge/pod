//
//  FavouritesEditRow.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct FavouritesEditRow: View {
    @ObservedObject var collectionItem: CollectionItem
    let pod: Pod
    
    var body: some View {
        HStack(spacing: 10) {
            pod.image
                .resizable()
                .background(pod.color)
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            Text((pod.name ?? "").uppercased())
                .font(.custom("FSLucasPro-Med", size: 16))
            if pod.decaffeinated ?? false {
                Decaffeinated()
                    .padding(.leading, -2)
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
