//
//  ItemPreview.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 30.03.2026.
//

import Foundation

struct ItemPreview: Identifiable, Hashable {
    let id: Int
    let title: String
    let imagePath: String
    var sitePath: String? = nil
}
