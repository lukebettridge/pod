//
//  TrendsHistory.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import SwiftUI

struct TrendsHistory: View {
    let logItems: FetchedResults<LogItem>
    let pods: [Pod]
    
    @State var isEditing: Bool = false
    
    var body: some View {
        Section(header: HStack {
//            Text("History").font(.title2).fontWeight(.semibold)
            Spacer()
            Button(action: {
                withAnimation(.linear(duration: 0.25)) {
                    isEditing.toggle()
                }
            }) {
                Text(isEditing ? "Done" : "Edit").fontWeight(.regular)
                    .animation(.none)
            }
        }) {
            ForEach (logItems) { logItem in
                if let pod = pods.first(where: { $0.id == logItem.podId }) {
                    TrendsHistoryRow(
                        pod: pod,
                        logItem: logItem,
                        isEditing: $isEditing
                    )
                }
            }
        }
        .onAppear {
            isEditing = false
        }
    }
}
