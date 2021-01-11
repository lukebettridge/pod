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
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                TrendsCharts()
                
                Divider()
                    .padding(.vertical)
                
                TrendsHistory(
                    pods: $pods,
                    logItems: logItems
                )
            }
            .padding()
            .padding(.bottom, 30)
        }
        .background(
            Color(colorScheme == .dark ? UIColor.systemBackground : UIColor.secondarySystemBackground)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
