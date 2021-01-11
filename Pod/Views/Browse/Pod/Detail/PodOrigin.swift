//
//  PodOrigin.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodOrigin: View {
    let origin: String?
    
    var body: some View {
        if let origin = origin {
            PodField(header: "Origin") {
                Text(origin)
            }
        }
    }
}

struct PodOrigin_Previews: PreviewProvider {
    static var previews: some View {
        PodOrigin(origin: "South America")
    }
}
