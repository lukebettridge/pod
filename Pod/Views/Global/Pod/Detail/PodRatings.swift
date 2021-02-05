//
//  PodRatings.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodRatings: View {
    let ratings: Dictionary<Pod.RatingType, Int>
    let color: Color
    
    var body: some View {
        if let acidity = ratings[.acidity], let bitterness = ratings[.bitterness] {
            HStack(spacing: 10) {
                PodField(header: "Acidity") {
                    PodScale(value: acidity, color: color)
                }
                
                PodField(header: "Bitterness") {
                    PodScale(value: bitterness, color: color)
                }
            }
        }
        
        if let body = ratings[.body], let roasting = ratings[.roasting] {
            HStack(spacing: 10) {
                PodField(header: "Body") {
                    PodScale(value: body, color: color)
                }
                
                PodField(header: "Roasting") {
                    PodScale(value: roasting, color: color)
                }
            }
        }
    }
}

struct PodRatings_Previews: PreviewProvider {
    static var previews: some View {
        PodRatings(ratings: [.acidity: 1, .bitterness: 2, .body: 3, .roasting: 4], color: .accentColor)
    }
}
