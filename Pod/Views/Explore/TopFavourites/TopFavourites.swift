//
//  TopFavourites.swift
//  Pod
//
//  Created by Luke Bettridge on 05/02/2021.
//

import SwiftUI

struct TopFavourites: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: ContentViewModel
    
    var topFavourites: [TopFavouritesItem]
    
    init(_ topFavourites: [TopFavouritesItem]) {
        self.topFavourites = topFavourites
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: -20) {
                ForEach(topFavourites.indices) { i in
                    if let pod = vm.pods.first(where: { $0.id == topFavourites[i].podId }) {
                        Button(action: { vm.openSheet(.pod, pod: pod) }) {
                            TopFavouritesRow(pod: pod, rank: i + 1)
                        }
                        if i != topFavourites.count - 1 {
                            Divider()
                        }
                    }
                }
            }
            .padding(.bottom)
            .padding(.horizontal)
        }
        .background(Color("PrimaryBackground").edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Top Favorites")
        .onAppear {
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: "Top Favourites",
                Analytics.AnalyticsParameterScreenClass: "TopFavourites"
            ])
        }
    }
}
