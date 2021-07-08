//
//  Trends.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import SwiftUI

struct Trends: View {
    @FetchRequest(fetchRequest: LogItem.fetchRequest()) var logItems: FetchedResults<LogItem>
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: ContentViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if logItems.count > 0 {
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 10) {
                            if RemoteConfig.config.boolValue(forKey: .show_trends_coming_soon) {
                                TrendsCharts()
                                Divider()
                                    .padding(.vertical)
                            }
                            TrendsHistory(
                                logItems: logItems,
                                pods: vm.pods
                            )
                        }
                        .padding()
                    }
                } else {
                    TrendsEmpty()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .background(
                Color("PrimaryBackground")
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationBarTitle("History")
        }
        .onAppear {
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: "Trends",
                Analytics.AnalyticsParameterScreenClass: "Trends"
            ])
        }
    }
}
