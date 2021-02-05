//
//  ExploreLinks.swift
//  Pod
//
//  Created by Luke Bettridge on 31/01/2021.
//

import SwiftUI

struct ExploreLinks: View {
    
    var mostPopular: [MostPopularItem] {
        (RemoteConfig.config.jsonValue(forKey: .most_popular) as? [[String: Any]] ?? [])
            .map { MostPopularItem($0) }
    }
    
    var topFavourites: [TopFavouritesItem] {
        (RemoteConfig.config.jsonValue(forKey: .top_favourites) as? [[String: Any]] ?? [])
            .map { TopFavouritesItem($0) }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            NavigationLink(destination: Browse(title: "All Capsules")) {
                ExploreLink(
                    icon: "square.grid.2x2.fill",
                    title: "All Capsules"
                )
            }
            if mostPopular.count > 0 {
                NavigationLink(destination: MostPopular(mostPopular)) {
                    ExploreLink(
                        icon: "number.square.fill",
                        title: "Most Popular",
                        subtitle: "Updated daily"
                    )
                }
            }
            if topFavourites.count > 0 {
                NavigationLink(destination: TopFavourites(topFavourites)) {
                    ExploreLink(
                        icon: "star.square.fill",
                        title: "Top Favorites",
                        subtitle: "Updated daily"
                    )
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}
