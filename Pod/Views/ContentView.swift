//
//  ContentView.swift
//  Pod
//
//  Created by Luke Bettridge on 23/12/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var isShowingWelcomeView: Bool = !UserDefaults.standard.bool(forKey: "Launched")
    
    init() {
       UserDefaults.standard.set(true, forKey: "Launched")
    }
    
    var body: some View {
        TabView {
            Collection()
                .tabItem {
                    Image(systemName: "tray.full")
                    Text("Collection")
                }
            Browse()
                .tabItem {
                    Image("pod")
                        .font(Font.system(size: 18).weight(.medium))
                    Text("Browse")
                }
        }
        .sheet(isPresented: $isShowingWelcomeView) {
            WelcomeView(exit: { isShowingWelcomeView = false })
        }
    }
}
