//
//  CollectionItem.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 18.03.2026.
//

import Foundation

enum CollectionItem: String, CaseIterable {
    case character, volume, issue, movie
}

extension CollectionItem: CustomStringConvertible {
    var description: String {
        self.rawValue.capitalized + "s"
    }
}

extension CollectionItem: Identifiable {
    var id: Self { self }
}
