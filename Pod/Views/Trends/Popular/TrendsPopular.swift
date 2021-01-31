//
//  TrendsPopular.swift
//  Pod
//
//  Created by Luke Bettridge on 30/01/2021.
//

import SwiftUI
import Introspect

struct TrendsPopular: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.colorScheme) var colorScheme
    
    var mostPopular: [MostPopularItem]
    @Binding var pods: [Pod]
    
    @State var selectedPod: Pod?
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: -20) {
                ForEach(mostPopular.indices) { i in
                    if let pod = pods.first(where: { $0.id == mostPopular[i].podId }) {
                        Button(action: { selectedPod = pod }) {
                            TrendsPopularRow(pod: pod, rank: i + 1)
                        }
                        if i != mostPopular.count - 1 {
                            Divider()
                        }
                    }
                }
            }
            .padding(.bottom)
            .padding(.horizontal)
        }
        .navigationBarTitle("Most Popular")
        .sheet(item: $selectedPod) {
            PodPage(pod: $0, exit: { selectedPod = nil })
                .environment(\.managedObjectContext, managedObjectContext)
        }
        .onAppear {
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: "Most Popular",
                Analytics.AnalyticsParameterScreenClass: "TrendsPopular"
            ])
        }
    }
}
