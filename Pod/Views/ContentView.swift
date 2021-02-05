//
//  ContentView.swift
//  Pod
//
//  Created by Luke Bettridge on 23/12/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var vm = ContentViewModel()
    
    init() {
        UserDefaults.standard.set(true, forKey: "Launched")
    }
    
    var body: some View {
        GeometryReader { gp in
            ZStack {
                TabView {
                    Collection()
                        .tabItem {
                            Image(systemName: "person.crop.square.fill")
                            Text("Collection")
                        }
                    Explore()
                        .tabItem {
                            Image(systemName: "square.grid.2x2.fill")
                            Text("Explore")
                        }
                    Spacer()
                    Trends()
                        .tabItem {
                            Image(systemName: "chart.bar.fill")
                            Text("Trends")
                        }
                    Settings()
                        .tabItem {
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                        }
                }
                .environment(\.pods, vm.pods)
                .environmentObject(vm)
                
                LogCTA(action: { vm.openSheet(.log) }, gp: gp)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            if !UserDefaults.standard.bool(forKey: "Launched") {
                vm.openSheet(.welcome)
            }
        }
        .sheet(item: $vm.activeSheet) { sheet in
            Group {
                switch sheet {
                    case .favourites:
                        FavouritesView(exit: vm.closeSheet)
                    case .filter:
                            FilterView(
                                vm.selectedFilter,
                                exit: {
                                    vm.closeSheet()
                                    vm.selectedFilter = nil
                                }
                            )
                    case .log:
                        LogView(
                            isLoading: vm.isLoading,
                            exit: vm.closeSheet
                        )
                    case .pod:
                        PodView(
                            $vm.selectedPod,
                            exit: {
                                vm.closeSheet()
                                vm.selectedPod = nil
                            }
                        )
                    case .scanner:
                        ScannerView(exit: vm.closeSheet)
                    case .welcome:
                        WelcomeView(exit: vm.closeSheet)
                }
            }
            .environment(\.pods, vm.pods)
            .environment(\.managedObjectContext, managedObjectContext)
        }
    }
}
