//
//  PodView.swift
//  Pod
//
//  Created by Luke Bettridge on 31/01/2021.
//

import SwiftUI
import Introspect

struct PodView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var pod: Pod?
    var exit: () -> Void
    
    init(_ pod: Binding<Pod?>, exit: @escaping () -> Void) {
        self._pod = pod
        self.exit = exit
    }
    
    var body: some View {
        if let pod = pod {
            GeometryReader { gp in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        PodClose(exit: exit, color: pod.color)
                        PodTitle(pod: pod, gp: gp)
                        PodDetail(pod: pod)
                    }
                    .padding()
                    .padding(.bottom, 30)
                }
            }
            .background(
                colorScheme == .dark
                    ? Color(UIColor.systemBackground)
                    : pod.color
            )
            .edgesIgnoringSafeArea(.vertical)
            .onDisappear {
                if managedObjectContext.hasChanges {
                    try? managedObjectContext.save()
                }
            }
            .onAppear {
                Analytics.log(event: .view, data: [
                    Analytics.AnalyticsParameterScreenName: "Pod",
                    Analytics.AnalyticsParameterScreenClass: "PodView",
                    Analytics.AnalyticsParameterCapsuleId: pod.id!,
                    Analytics.AnalyticsParameterCapsuleName: pod.name!
                ])
            }
        }
    }
}
