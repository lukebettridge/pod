//
//  CollectionEdit.swift
//  Pod
//
//  Created by Luke Bettridge on 04/01/2021.
//

import SwiftUI

struct CollectionEdit: View {
    @Binding var pods: [Pod]
    var collectionItems: FetchedResults<CollectionItem>
    var exit: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                ForEach (collectionItems) { collectionItem in
                    if let pod = pods.first(where: { $0.id ?? "" == collectionItem.podId }) {
                        HStack(spacing: 10) {
                            Image(uiImage: pod.image != nil ? UIImage(data: pod.image!)! : UIImage(named: "Placeholder")!)
                                .resizable()
                                .background(pod.color != nil ? Color(hex: pod.color!) : Color.primary)
                                .frame(width: 40, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                            Text(pod.name ?? "")
                            if pod.decaffeinated ?? false {
                                Decaffeinated()
                                    .padding(.top, 1)
                                    .padding(.leading, -2)
                            }
                            Spacer()
                            Button(action: {
                                collectionItem.favourite.toggle()
                                collectionItem.save()
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            }) {
                                Image(systemName: collectionItem.favourite ? "star.fill" : "star")
                                    .foregroundColor(Color.accentColor)
                            }
                        }
                        .padding(.vertical, 2.5)
                    }
                }
            }
            .navigationBarTitle("Edit Favourites", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: exit) { Text("Done") }
            )
        }
    }
}
