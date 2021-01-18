//
//  FilterAvailable.swift
//  Pod
//
//  Created by Luke Bettridge on 17/01/2021.
//

import SwiftUI

struct FilterAvailable: View {
    @Binding var selected: Bool?
    
    var body: some View {
        Section(
            header:
                HStack {
                    Text("Available")
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
                        FilterAvailableRow(
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
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
