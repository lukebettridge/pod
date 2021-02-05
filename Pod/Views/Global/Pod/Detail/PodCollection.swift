//
//  PodCollection.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodCollection: View {
    @Binding var collectionItem: CollectionItem?
    let pod: Pod
    
    @State var isShowingAlert: Bool = false
    
    private func log() {
        Analytics.log(event: .addToCollection, data: [
            Analytics.AnalyticsParameterCapsuleId: pod.id,
            Analytics.AnalyticsParameterCapsuleName: pod.name
        ])
    }
    
    var body: some View {
        Button(action: {
            if collectionItem != nil {
                isShowingAlert = true
            } else {
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                CollectionItem.add(podId: pod.id ?? "")
                log()
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
