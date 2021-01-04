//
//  PodItem.swift
//  Pod
//
//  Created by Luke Bettridge on 31/12/2020.
//

import SwiftUI
import MessageUI

struct PodItem: View {
    var pod: Pod
    var exit: () -> Void
    var color: Color { pod.color != nil ? Color(hex: pod.color!) : Color(UIColor.systemBackground) }
    
    @State var isShowingMailView = false
    @State var mailViewResult: Result<MFMailComposeResult, Error>? = nil

    var body: some View {
        GeometryReader { gp in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { exit() }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(Color(UIColor.systemBackground))
                        }
                    }
                    PodItemTitle(pod: pod, gp: gp)
                    PodItemDetail(
                        pod: pod,
                        reportAction: { self.isShowingMailView.toggle() }
                    )
                }
                .padding()
                .padding(.bottom, 30)
            }
        }
        .background(color)
        .edgesIgnoringSafeArea(.vertical)
        .sheet(isPresented: $isShowingMailView) {
            MailView(
                result: self.$mailViewResult,
                toRecipients: ["support@pod-app.io"],
                subject: "Report: \(pod.name ?? "")"
            )
            .edgesIgnoringSafeArea(.vertical)
        }
    }
}
