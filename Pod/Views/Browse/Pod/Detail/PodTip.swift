//
//  PodTip.swift
//  Pod
//
//  Created by Luke Bettridge on 08/01/2021.
//

import SwiftUI

struct PodTip: View {
    let tip: String?
    
    var body: some View {
        if let tip = tip {
            PodField(header: "Tip") {
                Text(tip)
                    .font(.system(size: 14))
                    .lineSpacing(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct PodTip_Previews: PreviewProvider {
    static var previews: some View {
        PodTip(tip: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    }
}
