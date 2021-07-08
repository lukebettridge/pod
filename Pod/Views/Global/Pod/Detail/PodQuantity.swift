//
//  PodQuantity.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodQuantity: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var collectionItem: CollectionItem?
    
    var body: some View {
        if let collectionItem = collectionItem {
            HStack(spacing: 0) {
                Image(systemName: "minus")
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(Color("SecondaryBackground"))
                    .opacity(collectionItem.quantity > 0 ? 1 : 0.5)
                    .onTapGesture {
                        if collectionItem.quantity > 0 {
                            collectionItem.quantity -= 1
                            collectionItem.save()
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        }
                    }
                    .onLongPressGesture(minimumDuration: 0.1) {
                        if collectionItem.quantity > 9 {
                            collectionItem.quantity -= 10
                            collectionItem.save()
                            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        }
                    }
                
                Spacer()
                
                Text("\(collectionItem.quantity)")
                
                Spacer()
                
                Image(systemName: "plus")
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(Color("SecondaryBackground"))
                    .onTapGesture {
                        collectionItem.quantity += 1
                        collectionItem.save()
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
                    .onLongPressGesture(minimumDuration: 0.1) {
                        collectionItem.quantity += 10
                        collectionItem.save()
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                    }
            }
            .background(Color("SecondaryBackground").opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 12.5))
        }
    }
}

struct PodQuantity_Previews: PreviewProvider {
    private static var collectionItem: Binding<CollectionItem?> {
        Binding (
            get: { Optional(CollectionItem()) },
            set: { _ in }
        )
    }
    
    static var previews: some View {
        PodQuantity(collectionItem: collectionItem)
    }
}
