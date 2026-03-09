//
//  NavigationHandler.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 09.03.2026.
//

import Foundation

protocol NavigationHandler {
    func navigate(to route: AnyHashable)
    func pop()
    func popToRoot()
}
