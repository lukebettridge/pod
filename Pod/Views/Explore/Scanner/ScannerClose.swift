//
//  ScannerClose.swift
//  Pod
//
//  Created by Luke Bettridge on 05/02/2021.
//

import SwiftUI

struct ScannerClose: View {
    let exit: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: { exit() }) {
                Image(systemName: "xmark")
                    .font(Font.subheadline.bold())
                    .padding(10)
                    .background(
                        VisualEffectView(effect: UIBlurEffect(style: .dark))
                    )
                    .clipShape(Circle())
            }
        }
    }
}
