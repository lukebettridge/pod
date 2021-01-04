//
//  CollectionEmpty.swift
//  Pod
//
//  Created by Luke Bettridge on 28/12/2020.
//

import SwiftUI

struct CollectionEmpty: View {
    var body: some View {
        VStack {
            Image("pod.fill")
                .font(Font.system(size: 95).weight(.light))
                .foregroundColor(Color(UIColor.systemGray5))
                .padding(.bottom, 2)
            Text("Your collection is empty")
                .font(.title3)
                .fontWeight(.medium)
                .padding(.vertical, 1)
            Text("Find your pods in the Browse tab, press \(Image(systemName: "plus.circle.fill")) to add them to your collection.")
                .font(.subheadline)
        }
        .foregroundColor(Color(UIColor.systemGray3))
        .multilineTextAlignment(.center)
        .padding(.horizontal)
    }
}

struct CollectionEmpty_Previews: PreviewProvider {
    static var previews: some View {
        CollectionEmpty()
    }
}
