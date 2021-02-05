//
//  MostPopular.swift
//  Pod
//
//  Created by Luke Bettridge on 30/01/2021.
//

import SwiftUI
import Introspect

struct MostPopular: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: ContentViewModel
    
    var mostPopular: [MostPopularItem]
    
    init(_ mostPopular: [MostPopularItem]) {
        self.mostPopular = mostPopular
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: -20) {
                ForEach(mostPopular.indices) { i in
                    if let pod = vm.pods.first(where: { $0.id == mostPopular[i].podId }) {
                        Button(action: { vm.openSheet(.pod, pod: pod) }) {
                            MostPopularRow(pod: pod, rank: i + 1)
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
        .onAppear {
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: "Most Popular",
                Analytics.AnalyticsParameterScreenClass: "MostPopular"
            ])
        }
    }
}
