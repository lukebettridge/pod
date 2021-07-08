//
//  MostPopularRow.swift
//  Pod
//
//  Created by Luke Bettridge on 30/01/2021.
//

import SwiftUI

struct MostPopularRow: View {
    let pod: Pod
    let rank: Int
    
    var body: some View {
        ZStack {
            HStack(alignment: .lastTextBaseline, spacing: 1) {
                Text("#")
                    .font(.custom("FSLucasPro-SemiBd", size: 130))
                Text("\(rank)")
                    .font(.custom("FSLucasPro-SemiBd", size: 220))

                Spacer()
            }
            .foregroundColor(Color("SecondaryBackground"))
            HStack(spacing: 12.5) {
                pod.image
                    .resizable()
                    .frame(width: 130, height: 130)
                    .frame(width: 110, height: 110)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center, spacing: 5) {
                        Text((pod.name ?? "").uppercased())
                            .font(.custom("FSLucasPro-SemiBd", size: 18))
                            .foregroundColor(.primary)
                        if pod.decaffeinated {
                            Decaffeinated()
                                .padding(.bottom, 2)
                        }
                    }
                    
                    Text(pod.category?.name ?? pod.origin ?? "")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding(.leading, 15)
        }
    }
}
