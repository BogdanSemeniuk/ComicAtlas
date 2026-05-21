//
//  NavigationHandlerMock.swift
//  ComicAtlasTests
//
//  Created by Богдан Семенюк on 21.05.2026.
//

@testable import ComicAtlas
import Foundation

class NavigationHandlerMock<T: Hashable>: NavigationHandler {
    var path: [T] = []
    private(set) var navigationToCallCount = 0
    
    func navigate(to route: AnyHashable) {
        navigationToCallCount += 1
        guard let route = route as? T else { return }
        path.append(route)
    }
}
