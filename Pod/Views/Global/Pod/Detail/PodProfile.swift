//
//  PodProfile.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodProfile: View {
    @Environment(\.colorScheme) var colorScheme
    
    let notes: [String]?
    let profile: String?
    
    var body: some View {
        if let profile = profile, let notes = notes {
            PodField(header: "Profile") {
                VStack(alignment: .leading) {
                    Text(profile)
                        .font(.system(size: 14))
                        .lineSpacing(2)
                        .fixedSize(horizontal: false, vertical: true)
                    HStack {
                        ForEach(notes, id: \.self) { note in
                            Text(note)
                                .font(.caption)
                                .fontWeight(.medium)
                                .padding(.horizontal, 7.5)
                                .padding(.vertical, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color(colorScheme == .dark ? UIColor.tertiarySystemBackground : UIColor.systemGray6))
                                )
                        }
                    }
                }
            }
        }
    }
}

struct PodProfile_Previews: PreviewProvider {
    static var previews: some View {
        PodProfile(notes: ["Fruity", "Sweet"], profile: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    }
}
