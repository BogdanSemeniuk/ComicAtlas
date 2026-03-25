//
//  URL+PathComponent.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 25.03.2026.
//

import Foundation

enum PathComponent: String {
    case issues = "issues-cover"
}

extension URL {
    func appending(pathComponent: PathComponent) -> URL {
        appending(path: pathComponent.rawValue)
    }
}
