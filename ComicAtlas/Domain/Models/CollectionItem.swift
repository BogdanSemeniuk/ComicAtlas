//
//  CollectionItem.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 18.03.2026.
//

import Foundation

protocol CollectionItemRepresentable: CustomStringConvertible, CaseIterable, Hashable, Identifiable {}

enum CollectionItem: String, CollectionItemRepresentable {
    case character, volume, issue, movie
}

extension CollectionItem {
    var description: String {
        self.rawValue.capitalized + "s"
    }
}

extension CollectionItem {
    var id: Self { self }
}
