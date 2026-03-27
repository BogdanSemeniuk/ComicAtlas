//
//  ReferenceDTO.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 27.03.2026.
//

import Foundation

struct ReferenceDTO {
    let id: Int
    let name: String?
    let siteDetailUrl: String?
    
    init(_ reference: ReferenceModel) {
        self.id = reference.id
        self.name = reference.name
        self.siteDetailUrl = reference.siteDetailUrl
    }
}
