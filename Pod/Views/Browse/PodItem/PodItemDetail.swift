//
//  PodItemDetail.swift
//  Pod
//
//  Created by Luke Bettridge on 01/01/2021.
//

import SwiftUI
import ToastUI

struct PodItemDetail: View {
    let pod: Pod
    let reportAction: () -> Void
    var fetchRequest: FetchRequest<CollectionItem>
    var collectionItem: CollectionItem? { fetchRequest.wrappedValue.first }
    var color: Color { pod.color != nil ? Color(hex: pod.color!) : Color.primary }
    
    init(
        pod: Pod,
        reportAction: @escaping () -> Void
    ) {
        self.pod = pod
        self.reportAction = reportAction
        self.fetchRequest = FetchRequest(fetchRequest: CollectionItem.fetchRequest(podId: pod.id!))
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                if pod.decaffeinated ?? false {
                    PodItemTag("Decaffeinated", color: .red)
                        .foregroundColor(color)
                }
            }
        
            Group {

                if let origin = pod.origin {
                    PodItemField(header: "Origin") {
                        Text(origin)
                    }
                }
                
                HStack(spacing: 10) {
                    if let intensity = pod.intensity {
                        PodItemField(header: "Intensity") {
                            HStack(alignment: .center, spacing: 3.5) {
                                Text("\(intensity)")
                                Text("/13")
                                    .font(.caption2)
                                    .foregroundColor(Color(UIColor.systemGray2))
                            }
                        }
                    }
                    
                    if let price = pod.price {
                        PodItemField(header: "Price") {
                            Text(String(format: "£%.02f", price))
                        }
                    }
                }
                
                HStack(spacing: 10) {
                    Button(action: {
                        if let collectionItem = collectionItem {
                            CollectionItem.remove(collectionItem: collectionItem)
                        } else {
                            CollectionItem.add(podId: pod.id!)
                        }
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }) {
                        PodItemField {
                            VStack(alignment: .center, spacing: 5) {
                                Image(systemName: "text.badge.\(collectionItem != nil ? "checkmark" : "plus")")
                                    .font(.title2)
                                Text(collectionItem != nil ? "Remove" : "Add to Collection")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: reportAction) {
                        PodItemField {
                            VStack(alignment: .center, spacing: 5) {
                                Image(systemName: "flag")
                                    .font(.title2)
                                Text("Report")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                if let collectionItem = collectionItem {
                    Button(action: {
                        collectionItem.favourite.toggle()
                        collectionItem.save()
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }) {
                        PodItemField {
                            VStack(alignment: .center, spacing: 5) {
                                Image(systemName: collectionItem.favourite ? "star.fill" : "star")
                                    .font(.title2)
                                Text(collectionItem.favourite ? "Unfavourite" : "Favourite")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                if let description = pod.description {
                    PodItemField(header: "Description") {
                        Text(description)
                            .font(.system(size: 15))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
            }
            .foregroundColor(color)
            .padding(.vertical, 2)
            
        }
    }
}
