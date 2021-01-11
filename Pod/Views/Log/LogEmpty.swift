//
//  LogEmpty.swift
//  Pod
//
//  Created by Luke Bettridge on 10/01/2021.
//

import SwiftUI

struct LogEmpty: View {
    var body: some View {
        VStack(spacing: 7.5) {
            Spacer()
            Image(systemName: "tray.fill")
                .font(Font.system(size: 95).weight(.light))
                .padding(.bottom, 5)
            Text("Your collection is empty")
                .font(.title3)
                .fontWeight(.bold)
            Text("You must add to your collection to start logging the capsules you use.")
                .font(.subheadline)
                .padding(.bottom, 80)
            Spacer()
        }
        .foregroundColor(Color(UIColor.systemGray3))
        .multilineTextAlignment(.center)
        .padding(.horizontal)
    }
}

struct LogEmpty_Previews: PreviewProvider {
    static var previews: some View {
        LogEmpty()
    }
}
