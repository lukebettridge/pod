//
//  BrowseSection.swift
//  Pod
//
//  Created by Luke Bettridge on 31/01/2021.
//

import SwiftUI

struct BrowseSection: View {
    @Environment(\.pods) var pods
    let category: Category
    
    init(_ category: Category) {
        self.category = category
    }
    
    var body: some View {
        Section(
            header:
                VStack(alignment: .leading, spacing: 5) {
                    Text((category.name ?? "").uppercased())
                        .font(.custom("FSLucasPro-Bold", size: 18))
                    if let description = category.description {
                        Text(description)
                            .font(.caption)
                            .foregroundColor(Color.gray)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        ) {
            BrowseGrid(
                subtitleType: category.name == "Limited Edition" ? .year : .origin
            )
        }
    }
}
