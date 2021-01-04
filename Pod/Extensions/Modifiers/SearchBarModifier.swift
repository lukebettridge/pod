//
//  SearchBarModifier.swift
//  Pod
//
//  Created by Luke Bettridge on 31/12/2020.
//

import SwiftUI

struct SearchBarModifier: ViewModifier {
    let searchBar: SearchBar
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerResolver { viewController in
                    viewController.navigationItem.searchController = self.searchBar.searchController
                }
                .frame(width: 0, height: 0)
            )
    }
}
