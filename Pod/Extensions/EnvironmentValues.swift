//
//  EnvironmentValues.swift
//  Pod
//
//  Created by Luke Bettridge on 31/01/2021.
//

import SwiftUI

struct PodsEnvironmentKey: EnvironmentKey {
    static let defaultValue: [Pod] = []
}

extension EnvironmentValues {
    var pods: [Pod] {
        get { return self[PodsEnvironmentKey] }
        set { self[PodsEnvironmentKey] = newValue }
    }
}
