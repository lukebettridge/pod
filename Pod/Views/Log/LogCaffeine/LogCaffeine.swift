//
//  LogCaffeine.swift
//  Pod
//
//  Created by Luke Bettridge on 06/01/2021.
//

import SwiftUI
import HealthKit

struct LogCaffeine: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var authorizationStatus: HKAuthorizationStatus?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .top) {
                Image(systemName: "heart.text.square.fill")
                    .font(.system(size: 40))
                    .foregroundColor(colorScheme == .dark ? .primary : .accentColor)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Record to Apple Health")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("Record the amount of caffeine and water to the Health app.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Button(action: {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                if HealthKit.authorizationStatus() == .some(.notDetermined) {
                    HealthKit.authorize { success, error in
                        authorizationStatus = HealthKit.authorizationStatus()
                        if success && authorizationStatus == .some(.sharingAuthorized) {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        } else {
                            UINotificationFeedbackGenerator().notificationOccurred(.error)
                        }
                    }
                }
            }) {
                Group {
                    switch authorizationStatus {
                        case .some(.notDetermined):
                            Text("Allow")
                        case .some(.sharingAuthorized):
                            Image(systemName: "checkmark")
                        case .some(.sharingDenied):
                            Text("Give permission in the Settings app.")
                        default:
                            Text("Something went wrong.")
                    }
                }
                .font(.subheadline)
                .foregroundColor(Color.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 7.5)
                        .fill(colorScheme == .dark ? Color(UIColor.tertiarySystemBackground) : .accentColor)
                )
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(authorizationStatus != .some(.notDetermined))
        }
        .padding()
        .background(Color(colorScheme == .dark ? UIColor.secondarySystemBackground : UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
