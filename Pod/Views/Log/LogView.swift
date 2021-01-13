//
//  LogView.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI
import HealthKit

struct LogView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: CollectionItem.fetchRequest(sort: ["favourite": false, "createdAt": true])) var collectionItems: FetchedResults<CollectionItem>
    @StateObject var logVM = LogViewModel()
    
    @State var selectedPod: Pod?
    @State var selectedCup: String?
    @State var authorizationStatus: HKAuthorizationStatus? = HealthKit.authorizationStatus()

    let exit: () -> Void
    
    var cupVolume: Double { Pod.cupVolumes[selectedCup ?? ""] ?? 40 }
    let showLogCaffeine: Bool =
        ![nil, .some(.sharingAuthorized)].contains(HealthKit.authorizationStatus())
    
    var body: some View {
        NavigationView {
            Group {
                if logVM.isLoading {
                    ProgressView()
                } else {
                    GeometryReader { gp in
                        ZStack {
                            if collectionItems.count > 0 {
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack {
                                        if showLogCaffeine {
                                            VStack(spacing: 20) {
                                                LogCaffeine(authorizationStatus: $authorizationStatus)
                                                Divider()
                                            }
                                            .padding(.top)
                                            .padding(.horizontal)
                                        }
                                        
                                        LogPodList(
                                            selected: $selectedPod,
                                            pods: $logVM.pods,
                                            collectionItems: collectionItems
                                        )
                                        
                                        LogCupList(
                                            active: selectedPod != nil,
                                            selected: $selectedCup,
                                            pods: $logVM.pods,
                                            relevantCups: selectedPod?.cupSize ?? []
                                        )
                                    }
                                    .padding(.bottom, 120)
                                }
                            } else {
                                LogEmpty()
                            }
                            
                            LogActions(
                                gp: gp,
                                cancel: exit,
                                label: "\(selectedPod?.caffeine(cup: selectedCup) ?? "60")mg, \(String(format: "%.0f", cupVolume))ml",
                                log: {
                                    if let pod = selectedPod, let cup = selectedCup {
                                        var loggedToHealth = false
                                        HealthKit.write(
                                            dietaryCaffeine: pod.caffeine(cup: cup),
                                            dietaryWater: cupVolume,
                                            date: Date()
                                        ) { success, error in
                                            if success {
                                                loggedToHealth = true
                                            }
                                            
                                            if let collectionItem = collectionItems.first(where: { $0.podId == pod.id }) {
                                                if collectionItem.quantity > 0 {
                                                    collectionItem.quantity -= 1
                                                    try? context.save()
                                                }
                                            }
                                            LogItem.add(context, podId: pod.id!, cup: cup, loggedToHealth: loggedToHealth)
                                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                                            exit()
                                        }
                                    }
                                },
                                disabled: selectedCup == nil
                            )
                        }
                        .background(Color(colorScheme == .dark ? UIColor.systemBackground : UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all))
                    }
                }
            }
            .navigationBarTitle("Log Coffee")
            .onChange(of: selectedPod, perform: { _ in
                selectedCup = nil
            })
        }
    }
}
