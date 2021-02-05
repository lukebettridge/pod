//
//  BrowseRequest.swift
//  Pod
//
//  Created by Luke Bettridge on 11/01/2021.
//

import SwiftUI
import MessageUI

struct BrowseRequest: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isShowingMailView = false
    @State var mailViewResult: Result<MFMailComposeResult, Error>? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .top) {
                Image(systemName: "questionmark.square.fill")
                    .font(.system(size: 40))
                    .foregroundColor(colorScheme == .dark ? .primary : .accentColor)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Can't find a capsule?")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text("Let us know which Nespresso capsule is missing and we will add it very soon.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Button(action: { self.isShowingMailView.toggle() }) {
                Text("Get in touch")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 7.5)
                            .fill(colorScheme == .dark ? Color(UIColor.tertiarySystemBackground) : .accentColor)
                    )
            }
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $isShowingMailView) {
                MailView(
                    result: self.$mailViewResult,
                    toRecipients: ["support@pod-app.io"],
                    subject: "Capsule Request"
                )
                .edgesIgnoringSafeArea(.vertical)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
