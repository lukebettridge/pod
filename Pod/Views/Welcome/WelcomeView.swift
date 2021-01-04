//
//  WelcomeView.swift
//  Pod
//
//  Created by Luke Bettridge on 02/01/2021.
//

import SwiftUI

struct WelcomeView: View {
    var exit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
//            Image("Pod")
//                .resizable()
//                .frame(width: 60, height: 60)
//                .clipShape(RoundedRectangle(cornerRadius: 12.5))
//                .padding(.bottom, 5)
            
            Text("Hello there,\nwelcome to Pod.")
                .font(.largeTitle)
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 15) {
                
                WelcomeItem(
                    icon: "tray.and.arrow.down.fill",
                    title: "Collection",
                    description: "Organise and keep track of your collection."
                )
                
                WelcomeItem(
                    icon: "mail.stack.fill",
                    title: "Browse",
                    description: "Explore the entire range of coffee capsules."
                )
                
                WelcomeItem(
                    icon: "heart.text.square.fill",
                    title: "Health",
                    description: "Provides an easy way of tracking your caffeine intake.",
                    comingSoon: true
                )
                
            }
            .padding(.horizontal)
            
            Spacer()
            Spacer()
            
            Button(action: exit) {
                Text("Continue")
                    .foregroundColor(Color.white)
                    .fontWeight(.medium)
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accentColor)
                    )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
}
