//
//  EditFavourites.swift
//  Pod
//
//  Created by Luke Bettridge on 04/01/2021.
//

import SwiftUI

struct EditFavourites: View {
    @Binding var pods: [Pod]
    var collectionItems: FetchedResults<CollectionItem>
    var exit: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                ForEach (collectionItems) { collectionItem in
                    if let pod = pods.first(where: { $0.id ?? "" == collectionItem.podId }) {
                        EditFavouritesRow(collectionItem: collectionItem, pod: pod)
                    }
                }
            }
            .navigationBarTitle("Edit Favourites", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: exit) { Text("Done") }
            )
        }
        .onAppear {
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: "Edit Favourites",
                Analytics.AnalyticsParameterScreenClass: "EditFavourites"
            ])
        }
    }
}
