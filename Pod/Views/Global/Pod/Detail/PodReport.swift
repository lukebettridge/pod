//
//  PodReport.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI
import MessageUI

struct PodReport: View {
    let name: String?
    
    @State var isShowingMailView = false
    @State var mailViewResult: Result<MFMailComposeResult, Error>? = nil
    
    var body: some View {
        Button(action: { self.isShowingMailView.toggle() }) {
            PodField {
                VStack(alignment: .center, spacing: 5) {
                    Image(systemName: "flag")
                        .font(.title2)
                    Text("Report")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .edgesIgnoringSafeArea(.vertical)
        .sheet(isPresented: $isShowingMailView) {
            MailView(
                result: self.$mailViewResult,
                toRecipients: ["support@pod-app.io"],
                subject: "Report: \(name ?? "")"
            )
            .edgesIgnoringSafeArea(.vertical)
        }
    }
}

struct PodReport_Previews: PreviewProvider {
    static var previews: some View {
        PodReport(name: "Colombia")
    }
}
