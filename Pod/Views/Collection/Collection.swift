//
//  Collection.swift
//  Pod
//
//  Created by Luke Bettridge on 26/12/2020.
//

import SwiftUI
import CoreData

struct Collection: View {
    @FetchRequest(fetchRequest: CollectionItem.fetchRequest()) var collectionItems: FetchedResults<CollectionItem>
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var collectionVM = CollectionViewModel()
    
    @State private var selectedPod: Pod?
    
    var body: some View {
        NavigationView {
            Group {
                if collectionVM.isLoading {
                    ProgressView()
                } else {
                    if collectionItems.count > 0 {
                        CollectionList(
                            pods: $collectionVM.pods,
                            selectPod: { pod in selectedPod = pod },
                            collectionItems: collectionItems
                        )
                    } else {
                        CollectionEmpty()
                    }
                }
            }
            .navigationBarTitle("My Collection")
        }
        .navigationViewStyle(DefaultNavigationViewStyle())
        .sheet(item: $selectedPod) {
            PodItem(pod: $0, exit: { selectedPod = nil })
                .environment(\.managedObjectContext, managedObjectContext)
        }
    }
}
