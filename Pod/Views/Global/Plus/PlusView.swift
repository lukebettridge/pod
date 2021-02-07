//
//  PlusView.swift
//  Pod
//
//  Created by Luke Bettridge on 07/02/2021.
//

import SwiftUI

struct PlusView: View {
    //@EnvironmentObject var sm: StoreManager
    
    var body: some View {
        VStack {
            Text("Pod+")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            VStack(spacing: 10) {
                Button(action: {
                    //sm.purchaseProduct()
                }) {
                    Text("Purchase")
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(PlainButtonStyle())
                Button(action: {
                    //sm.restoreProducts()
                }) {
                    Text("Restore Purchases")
                        .foregroundColor(.accentColor)
                        .padding(.vertical, 12.5)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.accentColor, lineWidth: 2)
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
    }
}
