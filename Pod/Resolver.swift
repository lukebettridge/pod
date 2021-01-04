//
//  AppDelegate+Injection.swift
//  Pod
//
//  Created by Luke Bettridge on 23/12/2020.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { PodRepository() }.scope(application)
        register { BrandRepository() }.scope(application)
        register { CategoryRepository() }.scope(application)
    }
}
