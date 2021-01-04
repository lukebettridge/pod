//
//  Browse.swift
//  Pod
//
//  Created by Luke Bettridge on 28/12/2020.
//

import SwiftUI

struct Browse: View {
    @StateObject var browseVM = BrowseViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if browseVM.isLoading || browseVM.brands.count < 1 {
                    ProgressView()
                } else {
                    PodList(brand: browseVM.brands[0])
                    
                    
                    
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
        }
    }
}
