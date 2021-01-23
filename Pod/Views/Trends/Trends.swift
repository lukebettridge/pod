//
//  Trends.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import SwiftUI

struct Trends: View {
    @FetchRequest(fetchRequest: LogItem.fetchRequest()) var logItems: FetchedResults<LogItem>
    @StateObject var trendsVM = TrendsViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if trendsVM.isLoading {
                    ProgressView()
                } else {
                    if logItems.count > 0 {
                        TrendsList(
                            pods: $trendsVM.pods,
                            logItems: logItems
                        )
                    } else {
                        TrendsEmpty()
                    }
                }
            }
            .navigationBarTitle("Trends")
            .onAppear {
                Analytics.log(event: .view, data: [
                    Analytics.AnalyticsParameterScreenName: "Trends",
                    Analytics.AnalyticsParameterScreenClass: "Trends"
                ])
            }
        }
    }
}
