//
//  LogCup.swift
//  Pod
//
//  Created by Luke Bettridge on 06/01/2021.
//

import SwiftUI

struct LogCup: View {
    var active: Bool
    @Binding var selected: String?
    @Binding var pods: [Pod]
    var relevantCups: [String]
    
    @State var alertCup: String?
    var cups: [String] {
        defaultCups +
        pods.flatMap { $0.cupSize }.unique
            .filter { !defaultCups.contains($0) }
            .sorted { $0.lowercased() < $1.lowercased() }
    }
    let defaultCups = ["Ristretto", "Espresso", "Lungo"]
    
    var gridItem = GridItem(.fixed(85), spacing: 1)
    
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
                    rows: Array(
                        repeating: gridItem,
                        count: min(Int((Double(cups.count) / 4.0).rounded(.up)), 2)
                    ),
                    spacing: 1
                ) {
                    ForEach(cups, id: \.self) { cup in
                        LogCupRow(
                            cup: cup,
                            selected: selected == cup,
                            disabled: !relevantCups.contains(cup)
                        )
                        .onTapGesture {
                            if active && selected != cup {
                                if relevantCups.contains(cup) {
                                    selected = cup
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                } else {
                                    alertCup = cup
                                }
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            }
            .alert(item: $alertCup) { cup in
                Alert(
                    title: Text("Select \(cup)"),
                    message: Text("You wouldn't usually have this capsule as \(cup.article) \(cup), would you like to select this cup anyway?"),
                    primaryButton: .default(Text("Select")) {
                        selected = cup
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}
