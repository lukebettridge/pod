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
            
            Text("Hello there,\nwelcome to Pod.")
                .font(.largeTitle)
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 15) {
                
                WelcomeItem(
                    icon: "books.vertical.fill",
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
                    description: "Provides an easy way of tracking your water and caffeine intake."
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
        .background(Color("PrimaryBackground").edgesIgnoringSafeArea(.all))
        .onAppear {
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: "Welcome",
                Analytics.AnalyticsParameterScreenClass: "WelcomeView"
            ])
        }
    }
}
