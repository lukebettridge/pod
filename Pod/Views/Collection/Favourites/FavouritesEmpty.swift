//
//  FavouritesEmpty.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct FavouritesEmpty: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: "star.fill")
                .font(Font.system(size: 50).weight(.light))
                .foregroundColor(Color(UIColor.systemGray5))
                .padding(.bottom, 5)
            Text("You have no favorites")
                .font(.headline)
                .fontWeight(.medium)
            Text("Find your pods in the Browse tab, press \(Image(systemName: "star")) to add them to your favorites.")
                .font(.caption)
                .fixedSize(horizontal: false, vertical: true)
        }
        .foregroundColor(Color(UIColor.systemGray3))
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.top, 18.5)
        .padding(.bottom, 21)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color.white
                )
        )
    }
}

struct FavouritesEmpty_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesEmpty()
    }
}
