//
//  FilterDecaffeinated.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import SwiftUI

struct FilterDecaffeinated: View {
    @Binding var selected: Bool?
    
    var body: some View {
        Section(
            header:
                HStack {
                    Text("Decaffeinated")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
                .padding(.bottom, 5)
        ) {
            HStack {
                HStack(spacing: 1) {
                    ForEach(["Yes", "No"]) { option in
                        FilterDecaffeinatedRow(
                            option: option,
                            selected:
                                (selected == true && option == "Yes") ||
                                (selected == false && option == "No")
                        )
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            if (selected == true && option == "Yes") ||
                                (selected == false && option == "No") {
                                selected = nil
                            } else {
                                selected = option == "Yes"
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 7.5))
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
