//
//  FilterRatingGroup.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import SwiftUI

struct FilterRatingGroup: View {
    @Binding var acidity: Int?
    @Binding var bitterness: Int?
    @Binding var ratingBody: Int?
    @Binding var roasting: Int?
    
    var body: some View {
        Section(
            header:
                HStack {
                    Text("Rating")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
        ) {
            VStack {
                FilterRating(ratingType: "Acidity", selected: $acidity)
                FilterRating(ratingType: "Bitterness", selected: $bitterness)
                FilterRating(ratingType: "Body", selected: $ratingBody)
                FilterRating(ratingType: "Roasting", selected: $roasting)
            }
        }
    }
}
