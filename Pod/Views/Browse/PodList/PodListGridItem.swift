//
//  PodListGridItem.swift
//  Pod
//
//  Created by Luke Bettridge on 29/12/2020.
//

import SwiftUI

struct PodListGridItem: View {
    @ObservedObject var pod: Pod
    var selectPod: (Pod) -> Void
    var preferredSubtitle: Pod.SubtitleType
    var fetchRequest: FetchRequest<CollectionItem>
    
    var collectionItem: CollectionItem? { fetchRequest.wrappedValue.first }
    var subtitle: String {
        if preferredSubtitle == .year, let introduced = pod.introduced {
            return String(introduced)
        } else if preferredSubtitle == .category, let category = pod.category?.name {
            return String(category)
        }
        return pod.origin ?? ""
    }
    
    init(
        pod: Pod,
        selectPod: @escaping (Pod) -> Void,
        preferredSubtitle: Pod.SubtitleType
    ) {
        self.pod = pod
        self.selectPod = selectPod
        self.preferredSubtitle = preferredSubtitle
        self.fetchRequest = FetchRequest(fetchRequest: CollectionItem.fetchRequest(podId: pod.id!))
    }
    
    var body: some View {
        Button(action: {
            selectPod(pod)
        }) {
            VStack(alignment: .leading) {
                ZStack {
                    pod.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 125, height: 125)
                        .frame(width: 90, height: 90)
                    if collectionItem != nil {
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color(UIColor.systemGray3))
                                    .padding(.trailing, -10)
                            }
                            Spacer()
                        }
                    }
                }
                HStack {
                    Text((pod.name ?? "").uppercased())
                        .font(.custom("FSLucasPro-Bold", size: 12))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    if pod.decaffeinated {
                        Decaffeinated()
                            .padding(.bottom, 2)
                    }
                }
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .frame(width: 120)
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .contextMenu {
            if let collectionItem = collectionItem {
                Button(action: {
                    collectionItem.favourite.toggle()
                    collectionItem.save()
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }) {
                    HStack {
                        Text(collectionItem.favourite ? "Unfavourite" : "Favourite")
                        Image(systemName: "star.\(collectionItem.favourite ? "slash" : "fill")")
                    }
                }
            }
            Button(action: {
                if let collectionItem = collectionItem {
                    CollectionItem.remove(collectionItem: collectionItem)
                } else if let id = pod.id {
                    CollectionItem.add(podId: id)
                }
                UIImpactFeedbackGenerator().impactOccurred(intensity: 1)
            }) {
                HStack {
                    Text("\(collectionItem != nil ? "Remove from" : "Add to") Collection")
                    Image(systemName: "text.badge.\(collectionItem != nil ? "minus" : "plus")")
                }
            }
        }
    }
}
