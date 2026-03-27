//
//  Refernce.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 27.03.2026.
//

import Foundation

struct Reference: Identifiable, Hashable {
    let id: Int
    let name: String?
    let siteDetailUrl: String?
    
    init(dto: ReferenceDTO) {
        self.id = dto.id
        self.name = dto.name
        self.siteDetailUrl = dto.siteDetailUrl
    }
}
