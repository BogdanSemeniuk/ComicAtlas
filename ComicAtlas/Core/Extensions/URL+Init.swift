//
//  URL+Init.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 25.03.2026.
//

import Foundation

extension URL {
    init(safeString string: String) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid URL string: \(string)")
        }
        self = url
    }
}
