//
//  PodNotes.swift
//  Pod
//
//  Created by Luke Bettridge on 09/01/2021.
//

import SwiftUI
import Introspect

struct PodNotes: View {
    @Binding var collectionItem: CollectionItem?
    
    init(collectionItem: Binding<CollectionItem?>) {
        self._collectionItem = collectionItem
        UITextView.appearance().backgroundColor = .clear
        UITextView.appearance().textContainerInset = .zero
        
    }
    
    private var notes: Binding<String> {
        return Binding (
            get: { collectionItem?.notes ?? "" },
            set: { newValue in
                collectionItem?.notes = newValue
            }
        )
    }
    
    var body: some View {
        if collectionItem != nil {
            PodField(header: "Notes") {
                ZStack {
                    if notes.wrappedValue.isEmpty {
                        HStack {
                            VStack {
                                Text("Add your own notes here...")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(UIColor.systemGray3))
                                    .padding(.top, 2)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    TextEditor(text: notes)
                        .font(.system(size: 14))
                        .lineSpacing(2)
                        .padding(.horizontal, -5)
                }
                .frame(minHeight: 36)
            }
        }
    }
}
