//
//  WelcomeItem.swift
//  Pod
//
//  Created by Luke Bettridge on 02/01/2021.
//

import SwiftUI

struct WelcomeItem: View {
    var icon: String
    var title: String
    var description: String
    var comingSoon: Bool = false
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(Color.accentColor)
                .frame(width: 50)
                .padding(.trailing, 7.5)
            VStack(alignment: .leading, spacing: 2.5) {
                HStack {
                    Text(title).bold()
                    if (comingSoon) {
                        Text("Coming Soon")
                            .font(.caption)
                            .foregroundColor(Color(UIColor.systemGray2))
                    }
                }
                Text(description)
                    .foregroundColor(.gray)
            }
            .font(.subheadline)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
