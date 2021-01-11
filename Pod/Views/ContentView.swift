//
//  ContentView.swift
//  Pod
//
//  Created by Luke Bettridge on 23/12/2020.
//

import SwiftUI
import CoreData

enum ContentViewActiveSheet: Identifiable {
    case welcome, log
    var id: Int { hashValue }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var activeSheet: ContentViewActiveSheet? =
        !UserDefaults.standard.bool(forKey: "Launched") ? .welcome : nil
    
    init() {
        UserDefaults.standard.set(true, forKey: "Launched")
    }
    
    var body: some View {
        GeometryReader { gp in
            ZStack {
                TabView {
                    Collection()
                        .tabItem {
                            Image(systemName: "rectangle.fill.badge.person.crop")
                            Text("Collection")
                        }
                    Trends()
                        .tabItem {
                            Image(systemName: "chart.bar.fill")
                            Text("Trends")
                        }
                    Spacer()
                    Browse()
                        .tabItem {
                            Image(systemName: "square.grid.3x2.fill")
                            Text("Browse")
                        }
                    Settings()
                        .tabItem {
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                        }
                }
                
                LogCTA(action: {
                    activeSheet = .log
                }, gp: gp)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(item: $activeSheet) { item in
            Group {
                switch item {
                    case .welcome:
                        WelcomeView(exit: { activeSheet = nil })
                    case .log:
                        LogView(exit: { activeSheet = nil })
                }
            }
            .environment(\.managedObjectContext, managedObjectContext)
        }
    }
}
