//
//  ReferenceModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 24.03.2026.
//

import Foundation

struct ReferenceModel: Codable, Sendable {
    let id: Int
    let name: String
    let siteDetailUrl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case siteDetailUrl = "site_detail_url"
    }
}
