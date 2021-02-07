//
//  Settings.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import SwiftUI

struct Settings: View {
    @State var isShowingAlert = false
    
    @State var variety = UserDefaults.standard.integer(forKey: "Variety")
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    footer:
                        Text("Set which capsule type you'd prefer to see first when browsing all capsules.")
                ) {
                    Picker("Default Capsule Type", selection: $variety) {
                        Text("Original").tag(0)
                        Text("Vertuo").tag(1)
                    }
                }
                
                Section(header: Text("About")) {
                    if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("\(appVersion)")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section(
                    header: Text("Legal"),
                    footer:
                        Text("All images and content relating to Nespresso coffee capsules are the property of Nestlé Nespresso S.A.")
                ) {
                    Link("Privacy Policy", destination: URL(string: "https://pod-app.io/privacy-policy")!)
                    Link("Copyright", destination: URL(string: "https://www.nespresso.com/uk/en/legal")!)
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(
                trailing:
                    Menu {
                        Button(action: {
                            isShowingAlert.toggle()
                        }) {
                            Label("Log Tea", systemImage: "leaf.fill")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.title2)
                    }
            )
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Log Tea"),
                    message: Text("If you prefer to drink tea instead, Pod can log a 250ml brew to the Health app for the average caffeine quantity in tea (24mg / 100ml)."),
                    primaryButton: .default(Text("Log")) {
                        HealthKit.write(dietaryCaffeine: 60, dietaryWater: 250, date: Date()) { success, error in
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .onAppear {
                Analytics.log(event: .view, data: [
                    Analytics.AnalyticsParameterScreenName: "Settings",
                    Analytics.AnalyticsParameterScreenClass: "Settings"
                ])
            }
        }
        .onChange(of: variety) { variety in
            UserDefaults.standard.set(variety, forKey: "Variety")
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
