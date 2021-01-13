//
//  TrendsHistoryRow.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import SwiftUI

struct TrendsHistoryRow: View {
    @Environment(\.colorScheme) var colorScheme
    
    let pod: Pod
    let logItem: LogItem
    
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7.5) {
            HStack(spacing: 7.5) {
                pod.image
                    .resizable()
                    .background(pod.color)
                    .frame(width: 25, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                HStack(alignment: .center, spacing: 5) {
                    Text((pod.name ?? "").uppercased())
                        .font(.custom("FSLucasPro-SemiBd", size: 16))
                        .foregroundColor(.primary)
                    if pod.decaffeinated ?? false {
                        Decaffeinated()
                    }
                }
                Spacer()
                Text("\(logItem.createdAt, formatter: dateFormat)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            HStack(alignment: .lastTextBaseline, spacing: 1) {
                Text("\(pod.caffeine(cup: logItem.cup))")
                    .font(.custom("FSLucasPro-SemiBd", size: 45))
                Text("mg")
                    .font(.custom("FSLucasPro-SemiBd", size: 14))
                    .foregroundColor(.gray)
                Spacer()
                Image(logItem.cup)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(colorScheme == .dark ? .white : .gray)
                    .frame(width: 17.5, height: 17.5, alignment: .bottom)
            }
            .padding(.bottom, -5)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color.white
                )
        )
    }
}

//if logItem.loggedToHealth {
//    Text("\(Image(systemName: "heart.fill")) Logged to Apple Health")
//        .font(.system(size: 8))
//        .fontWeight(.medium)
//        .foregroundColor(.accentColor)
//}
