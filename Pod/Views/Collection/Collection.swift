//
//  Collection.swift
//  Pod
//
//  Created by Luke Bettridge on 26/12/2020.
//

import SwiftUI
import CoreData

struct Collection: View {
    @FetchRequest(fetchRequest: CollectionItem.fetchRequest()) var collectionItems: FetchedResults<CollectionItem>
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: ContentViewModel
    
    var favourites: [CollectionItem] {
        collectionItems.filter { $0.favourite }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if collectionItems.count > 0 {
                    ScrollView(.vertical) {
                        VStack(spacing: 15) {
                            Text("You have \(collectionItems.reduce(0) { $0 + $1.quantity }) capsules in your collection.")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .padding(.top, -16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Section(header: HStack {
                                Text("Favorites").font(.title2).fontWeight(.semibold)
                                Spacer()
                                Button(action: { vm.openSheet(.favourites) }) {
                                    Text("Edit").fontWeight(.regular)
                                }
                            }) {
                                if favourites.count > 0 {
                                    ForEach (favourites) { collectionItem in
                                        if let pod = vm.pods.first(where: { $0.id == collectionItem.podId }) {
                                            CollectionRow(collectionItem, pod: pod)
                                        }
                                    }
                                } else {
                                    FavouritesEmpty()
                                }
                            }
                            
                            Divider()
                                .padding(.vertical)
                            
                            ForEach (collectionItems.filter { !$0.favourite }) { collectionItem in
                                if let pod = vm.pods.first(where: { $0.id == collectionItem.podId }) {
                                    CollectionRow(collectionItem, pod: pod)
                                }
                            }
                        }
                        .padding()
                        .padding(.bottom, 30)
                    }
                } else {
                    CollectionEmpty()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .background(
                Color("PrimaryBackground")
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationBarTitle("My Collection")
        }
        .onAppear {
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: "My Collection",
                Analytics.AnalyticsParameterScreenClass: "Collection"
            ])
        }
    }
}
