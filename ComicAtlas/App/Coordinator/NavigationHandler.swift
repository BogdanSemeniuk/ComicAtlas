//
//  NavigationHandler.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 09.03.2026.
//

import Foundation

protocol NavigationHandler: AnyObject {
    associatedtype NavigationRoute: Hashable
    var path: [NavigationRoute] { get set }
    func navigate(to route: AnyHashable)
    func pop()
    func popToRoot()
}

extension NavigationHandler {
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path = []
    }
}
