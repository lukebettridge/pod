//
//  BrowsePicker.swift
//  Pod
//
//  Created by Luke Bettridge on 31/01/2021.
//

import SwiftUI

struct BrowsePicker: View {
    var varieties: [String]
    @Binding var variety: Int
    
    var body: some View {
        if varieties.count > 1 {
            Picker("Variety", selection: $variety) {
                ForEach(varieties, id: \.self) { variety in
                    if let index = varieties.firstIndex(of: variety) {
                        Text(variety).tag(index)
                    }
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
        }
    }
}
