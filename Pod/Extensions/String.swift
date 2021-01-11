//
//  String.swift
//  Pod
//
//  Created by Luke Bettridge on 10/01/2021.
//

extension String: Identifiable {
    
    public var id: String { self }
    
    public var article: String {
        if let firstCharacter = self.first {
            if ["A", "E", "I", "O", "U"].contains(firstCharacter.uppercased()) {
                return "an"
            }
        }
        return "a"
    }
}
