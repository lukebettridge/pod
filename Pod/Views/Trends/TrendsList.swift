//
//  TrendsList.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import SwiftUI

struct TrendsList: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var pods: [Pod]
    var logItems: FetchedResults<LogItem>
    
    var mostPopular: [MostPopularItem] {
        (RemoteConfig.config.jsonValue(forKey: .most_popular) as? [[String: Any]] ?? [])
            .map { MostPopularItem($0) }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                
                if RemoteConfig.config.boolValue(forKey: .show_trends_coming_soon) {
                    TrendsCharts()
                    Divider()
                        .padding(.vertical)
                }
                
                if mostPopular.count > 0 {
                    NavigationLink(
                        destination: TrendsPopular(mostPopular: mostPopular, pods: $pods)
                    ) {
                        TrendsPopularLink()
                    }
                    Divider()
                        .padding(.vertical)
                }
                
                TrendsHistory(
                    pods: $pods,
                    logItems: logItems
                )
            }
            .padding()
            
        }
        .background(
            Color(colorScheme == .dark ? UIColor.systemBackground : UIColor.secondarySystemBackground)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
