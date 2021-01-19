//
//  Decaffeinated.swift
//  Pod
//
//  Created by Luke Bettridge on 27/12/2020.
//

import SwiftUI

struct Decaffeinated: View {
    var long: Bool = false
    
    var body: some View {
        Text(long ? "DECAFFEINATED" : "DECAF")
            .font(.custom("FSLucasPro-Bold", size: long ? 12 : 7.5))
            .foregroundColor(.white)
            .padding(.top, 2)
            .padding(.bottom, 1)
            .padding(.horizontal, 3)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.red)
            )
    }
}
