//
//  FilterCup.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import SwiftUI

struct FilterCup: View {
    @Binding var selected: String?
    
    var cups = Pod.cupVolumes.map { $0.key }
    var gridItem = GridItem(.fixed(60), spacing: 1)
    
    var body: some View {
        Section(
            header:
                HStack {
                    Text("Cup")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
        ) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(
                    rows: Array(repeating: gridItem, count: 2),
                    spacing: 1
                ) {
                    ForEach(cups, id: \.self) { cup in
                        FilterCupRow(
                            cup: cup,
                            selected: selected == cup
                        )
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            if selected != cup {
                                selected = cup
                            } else {
                                selected = nil
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            }
        }
    }
}
