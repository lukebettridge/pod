//
//  PodPage.swift
//  Pod
//
//  Created by Luke Bettridge on 31/12/2020.
//

import SwiftUI
import MessageUI

struct PodPage: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var pod: Pod
    var exit: () -> Void

    var body: some View {
        GeometryReader { gp in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    PodPageClose(exit: exit, color: pod.color)
                    PodPageTitle(pod: pod, gp: gp)
                    PodPageDetail(pod: pod)
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
                Analytics.AnalyticsParameterScreenClass: "PodPage",
                Analytics.AnalyticsParameterCapsuleId: pod.id,
                Analytics.AnalyticsParameterCapsuleName: pod.name!
            ])
        }
    }
}
