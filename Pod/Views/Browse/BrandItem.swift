//
//  BrandItem.swift
//  Pod
//
//  Created by Luke Bettridge on 28/12/2020.
//

import SwiftUI

struct BrandItem: View {
    @Environment(\.colorScheme) var colorScheme
    
    var brand: Brand
    @Binding var filter: PodFilter
    
    var body: some View {
        NavigationLink(destination: PodList(brand: brand, filter: $filter)) {
            VStack(spacing: 0) {
                brand.cover
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(Color(UIColor.systemGray6))
                    .frame(height: 150)
                    .clipped()
                HStack {
                    Text(brand.name ?? "")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(
                    colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color.white
                )
            }
            .contentShape(Rectangle())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
