//
//  PodTags.swift
//  Pod
//
//  Created by Luke Bettridge on 05/01/2021.
//

import SwiftUI

struct PodTags: View {
    @Environment(\.colorScheme) var colorScheme
    let pod: Pod
    
    var body: some View {
        HStack {
            HStack(alignment: .bottom) {
                ForEach(pod.cupSize, id: \.self) { cupSize in
                    Image(cupSize)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(colorScheme == .dark ? pod.color : .white)
                        .frame(width: 17.5, height: 17.5, alignment: .bottom)
                }
            }
            Spacer()
            if pod.decaffeinated ?? false {
                Decaffeinated(long: true)
            }
        }
    }
}

struct PodTags_Previews: PreviewProvider {
    static var previews: some View {
        PodTags(pod: Pod([:], documentID: ""))
    }
}
