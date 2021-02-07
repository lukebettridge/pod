//
//  CollectionEmpty.swift
//  Pod
//
//  Created by Luke Bettridge on 28/12/2020.
//

import SwiftUI

struct CollectionEmpty: View {
    var body: some View {
        VStack(spacing: 7.5) {
            Image(systemName: "tray.fill")
                .font(Font.system(size: 95).weight(.light))
                .padding(.bottom, 5)
            Text("Your collection is empty")
                .font(.title3)
                .fontWeight(.bold)
            Text("Find your pods in the Explore tab, press \(Image(systemName: "plus.circle.fill")) to add them to your collection.")
                .font(.subheadline)
        }
        .foregroundColor(Color(UIColor.systemGray3))
        .multilineTextAlignment(.center)
        .padding(.horizontal)
    }
}
