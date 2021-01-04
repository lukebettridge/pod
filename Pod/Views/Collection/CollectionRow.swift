//
//  CollectionRow.swift
//  Pod
//
//  Created by Luke Bettridge on 26/12/2020.
//

import SwiftUI

struct CollectionRow: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var pod: Pod
    var collectionItem: CollectionItem
    var selectPod: (Pod) -> Void
    var color: Color { pod.color != nil ? Color(hex: pod.color!) : Color(UIColor.systemBackground) }
    
    var body: some View {
        HStack(spacing: 12.5) {
            Image(uiImage: pod.image != nil ? UIImage(data: pod.image!)! : UIImage(named: "Placeholder")!)
                .resizable()
                .background(color)
                .frame(width: 55, height: 55)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(pod.name ?? "")
                    if pod.decaffeinated ?? false {
                        Decaffeinated()
                            .padding(.top, 1)
                            .padding(.leading, -2)
                    }
                }
                
                Text(pod.category?.name ?? pod.origin ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                selectPod(pod)
            }) {
                Image(systemName: "info.circle")
                    .font(.title2)
                    .foregroundColor(.accentColor)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color.white
                )
        )
        .contextMenu {
            Button(action: {
                CollectionItem.remove(collectionItem: collectionItem)
                UIImpactFeedbackGenerator().impactOccurred(intensity: 1)
            }) {
                HStack {
                    Text("Remove from Collection")
                    Image(systemName: "text.badge.checkmark")
                }
            }
        }
    }
}
