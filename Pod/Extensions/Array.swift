//
//  Array.swift
//  Pod
//
//  Created by Luke Bettridge on 06/01/2021.
//

extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}
