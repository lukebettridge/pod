//
//  TrendsHistory.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import SwiftUI

struct TrendsHistory: View {
    @Binding var pods: [Pod]
    var logItems: FetchedResults<LogItem>
    
    var body: some View {
        Section(header:
            Text("History")
                    .font(.title2)
                    .fontWeight(.semibold)
        ) {
            ForEach (logItems) { logItem in
                if let pod = pods.first(where: { $0.id == logItem.podId }) {
                    TrendsHistoryRow(
                        pod: pod,
                        logItem: logItem
                    )
                }
            }
        }
    }
}
