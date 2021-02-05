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
    @Binding var isEditing: Bool
    
    @State var isShowingAlert: Bool = false
    
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter
    }()
    
    var body: some View {
        HStack {
            if isEditing {
                Button(action: { isShowingAlert.toggle() }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                }
                .padding(.trailing, 5)
                .transition(
                    AnyTransition.move(edge: .leading).combined(with: .opacity)
                )
            }
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
                            .lineLimit(1)
                        if pod.decaffeinated {
                            Decaffeinated()
                        }
                    }
                    Spacer()
                    if let createdAt = logItem.createdAt {
                        Text("\(createdAt, formatter: dateFormat)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                if let cup = logItem.cup {
                    HStack(alignment: .lastTextBaseline, spacing: 1) {
                        Text("\(pod.caffeine(cup: cup))")
                            .font(.custom("FSLucasPro-SemiBd", size: 45))
                        Text("mg")
                            .font(.custom("FSLucasPro-SemiBd", size: 14))
                            .foregroundColor(.gray)
                        Spacer()
                        Image(cup)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(colorScheme == .dark ? .white : .gray)
                            .frame(width: 17.5, height: 17.5, alignment: .bottom)
                    }
                    .padding(.bottom, -5)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 15)
        .background(
            colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color.white
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("Remove from History"),
                message: Text("Are you sure you want to remove this beverage from your history?"),
                primaryButton: .default(Text("Remove")) {
                    withAnimation(.linear(duration: 0.25)) {
                        LogItem.remove(logItem: logItem)
                        UIImpactFeedbackGenerator().impactOccurred()
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}
