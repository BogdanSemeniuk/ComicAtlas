//
//  ImageModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 18.03.2026.
//

import Foundation

struct ImageModel: Codable, Sendable {
    let iconUrl: String
    let smallUrl: String
    
    enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url"
        case smallUrl = "small_url"
    }
}
