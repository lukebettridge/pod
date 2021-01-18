//
//  FilterRating.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import SwiftUI

struct FilterRating: View {
    var ratingType: String
    @Binding var selected: Int?
    
    var body: some View {
        Section(
            header:
                HStack {
                    Text(ratingType)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.top, 6)
                .padding(.horizontal)
        ) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(
                    rows: [GridItem(.fixed(50), spacing: 1)],
                    spacing: 1
                ) {
                    ForEach(1..<6) { rating in
                        FilterRatingRow(
                            rating: rating,
                            selected: selected == rating
                        )
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            if selected != rating {
                                selected = rating
                            } else {
                                selected = nil
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            }
        }
    }
}
