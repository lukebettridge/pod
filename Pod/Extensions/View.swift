//
//  View.swift
//  Pod
//
//  Created by Luke Bettridge on 29/12/2020.
//

import SwiftUI

extension View {
    func add(_ searchBar: SearchBar) -> some View {
        self.modifier(SearchBarModifier(searchBar: searchBar))
    }
}
