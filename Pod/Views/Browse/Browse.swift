//
//  Browse.swift
//  Pod
//
//  Created by Luke Bettridge on 28/12/2020.
//

import SwiftUI

struct Browse: View {
    @StateObject var browseVM = BrowseViewModel()
    
    @State private var isShowingFilterView = false
    
    var body: some View {
        NavigationView {
            Group {
                if browseVM.isLoading || browseVM.brands.count < 1 {
                    ProgressView()
                } else {
                    PodList(brand: browseVM.brands[0], filter: $browseVM.filter)
                    
//                    ScrollView(.vertical) {
//                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 30) {
//                            ForEach (browseVM.brands) { brand in
//                                BrandItem(brand: brand)
//                            }
//                        }
//                        .padding()
//                    }
                }
            }
            .navigationBarTitle("Browse")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        isShowingFilterView.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle\(browseVM.filter.active ? ".fill" : "")")
                            .font(.title2)
                    }
            )
        }
        .sheet(isPresented: $isShowingFilterView) {
            FilterView(filter: $browseVM.filter, exit: {
                isShowingFilterView.toggle()
            })
        }
        .onAppear {
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: "Browse",
                Analytics.AnalyticsParameterScreenClass: "Browse"
            ])
        }
    }
}
