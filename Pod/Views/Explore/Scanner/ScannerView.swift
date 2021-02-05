//
//  ScannerView.swift
//  Pod
//
//  Created by Luke Bettridge on 05/02/2021.
//

import SwiftUI
import MessageUI
import CodeScanner

enum ScannerViewActiveSheet: Identifiable {
    case mail, pod
    var id: Int { hashValue }
}

struct ScannerView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.pods) var pods
    
    let exit: () -> Void
    
    @State var activeSheet: ScannerViewActiveSheet? = nil
    @State var alertMessage: String? = nil
    @State var code: String? = nil
    @State var mailViewResult: Result<MFMailComposeResult, Error>? = nil
    @State var pod: Pod? = nil
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        if activeSheet == nil {
            switch result {
                case .success(let code):
                    self.code = String(code)
                    let pod = pods.first(where: { $0.barcodes.contains(String(code)) })
                    var analyticsData = [Analytics.AnalyticsParameterBarcode: String(code)]
                    if let pod = pod {
                        self.pod = pod
                        self.activeSheet = .pod
                        analyticsData[Analytics.AnalyticsParameterCapsuleId] = pod.id!
                        analyticsData[Analytics.AnalyticsParameterCapsuleName] = pod.name!
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    } else {
                        alertMessage = "A capsule with this barcode could not be found"
                        UINotificationFeedbackGenerator().notificationOccurred(.error)
                    }
                    Analytics.log(event: .scanBarcode, data: analyticsData)
            case .failure:
                alertMessage = "An error occurred while attempting to scan the barcode"
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            }
        }
    }
    
    var body: some View {
        ZStack {
            CodeScannerView(
                codeTypes: [.ean13],
                scanMode: .continuous,
                completion: handleScan
            )
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScannerClose(exit: exit)
                Spacer()
                Image(systemName: "viewfinder")
                    .font(.system(size: 250, weight: .ultraLight))
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .opacity(0.8)
                Spacer()
                Text("Find a code to scan")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(
                        VisualEffectView(effect: UIBlurEffect(style: .dark))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.bottom, 30)
            }
            .foregroundColor(.white)
            .padding()
        }
        .onAppear {
            Analytics.log(event: .view, data: [
                Analytics.AnalyticsParameterScreenName: "Scanner",
                Analytics.AnalyticsParameterScreenClass: "ScannerView"
            ])
        }
        .sheet(item: $activeSheet) { sheet in
            Group {
                switch sheet {
                    case .mail:
                        MailView(
                            result: $mailViewResult,
                            toRecipients: ["support@pod-app.io"],
                            subject: "Missing Barcode: \(code ?? "N/A")"
                        )
                        .edgesIgnoringSafeArea(.vertical)
                    case .pod:
                        PodView($pod, exit: {
                            activeSheet = nil
                        })
                }
            }
            .environment(\.managedObjectContext, managedObjectContext)
        }
        .alert(item: $alertMessage) { message in
            Alert(
                title: Text(message),
                primaryButton: .default(Text("Let us know"), action: { activeSheet = .mail }),
                secondaryButton: .cancel(Text("OK"))
            )
        }
    }
}
