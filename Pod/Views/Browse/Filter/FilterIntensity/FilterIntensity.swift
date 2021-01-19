//
//  FilterIntensity.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import SwiftUI

struct FilterIntensity<Content: View>: View {
    @Binding var selected: Int?
    var header: Content
    
    var gridItem = GridItem(.fixed(45), spacing: 1)
    
    init(
        selected: Binding<Int?>,
        @ViewBuilder header: () -> Content
    ) {
        self._selected = selected
        self.header = header()
    }
    
    var body: some View {
        Section(
            header:
                HStack {
                    Text("Intensity")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    header
                }
                .padding(.top)
                .padding(.horizontal)
        ) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(
                    rows: Array(repeating: gridItem, count: 2),
                    spacing: 1
                ) {
                    ForEach(0..<14) { intensity in
                        FilterIntensityRow(
                            intensity: intensity,
                            selected: selected == intensity
                        )
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            if selected != intensity {
                                selected = intensity
                            } else {
                                selected = nil
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 7.5))
                .padding(.horizontal)
            }
        }
    }
}
