//
//  TrendsEmpty.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import SwiftUI

struct TrendsEmpty: View {
    var body: some View {
        VStack(spacing: 7.5) {
            Image(systemName: "chart.bar.fill")
                .font(Font.system(size: 95).weight(.light))
                .padding(.bottom, 5)
            Text("You haven't logged any coffee")
                .font(.title3)
                .fontWeight(.bold)
            Text("Next time you use a capsule, tap the centre button below to log it in the app.")
                .font(.subheadline)
        }
        .foregroundColor(Color(UIColor.systemGray3))
        .multilineTextAlignment(.center)
        .padding(.horizontal)
    }
}

struct TrendsEmpty_Previews: PreviewProvider {
    static var previews: some View {
        TrendsEmpty()
    }
}
