//
//  Explore.swift
//  Pod
//
//  Created by Luke Bettridge on 31/01/2021.
//

import SwiftUI

struct Explore: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: ContentViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 10) {
                            Featured()
                            ExploreLinks()
                        }
                        .padding()
                        .padding(.bottom, 20)
                    }
                }
            }
            .background(
                Color("PrimaryBackground")
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationBarTitle("Explore")
            .navigationBarItems(
                trailing:
                    Button(action: { vm.openSheet(.scanner) }) {
                        Image(systemName: "barcode.viewfinder")
                            .font(.headline)
                    }
            )
        }
        .onAppear {
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: "Explore",
                Analytics.AnalyticsParameterScreenClass: "Explore"
            ])
        }
    }
}
