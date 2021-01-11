//
//  PodCollection.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodCollection: View {
    @Binding var collectionItem: CollectionItem?
    let podId: String?
    
    @State var isShowingAlert: Bool = false
    
    var body: some View {
        Button(action: {
            if collectionItem != nil {
                isShowingAlert = true
            } else {
                CollectionItem.add(podId: podId ?? "")
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            }
        }) {
            PodField {
                VStack(alignment: .center, spacing: 5) {
                    Image(systemName: "text.badge.\(collectionItem != nil ? "checkmark" : "plus")")
                        .font(.title2)
                    Text(collectionItem != nil ? "Remove" : "Add to Collection")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("Remove from Collection"),
                message: Text("Are you sure you want to remove this capsule from your collection?"),
                primaryButton: .default(Text("Remove")) {
                    CollectionItem.remove(collectionItem: collectionItem!)
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct PodCollection_Previews: PreviewProvider {
    private static var collectionItem: Binding<CollectionItem?> {
        Binding (
            get: { Optional(CollectionItem()) },
            set: { _ in }
        )
    }
    
    static var previews: some View {
        PodCollection(collectionItem: collectionItem, podId: "")
    }
}
