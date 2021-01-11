//
//  Settings.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("About")) {
                    if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("\(appVersion)")
                                .foregroundColor(.gray)
                        }
                    }
                    Link("Privacy Policy", destination: URL(string: "https://pod-app.io/privacy-policy")!)
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
