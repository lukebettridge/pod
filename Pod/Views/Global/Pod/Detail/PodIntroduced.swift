//
//  PodIntroduced.swift
//  Pod
//
//  Created by Luke Bettridge on 08/01/2021.
//

import SwiftUI

struct PodIntroduced: View {
    let introduced: Int?
    
    var body: some View {
        if let introduced = introduced {
            PodField(header: "Introduced") {
                Text(String(introduced))
            }
        }
    }
}

struct PodIntroduced_Previews: PreviewProvider {
    static var previews: some View {
        PodIntroduced(introduced: 2021)
    }
}
