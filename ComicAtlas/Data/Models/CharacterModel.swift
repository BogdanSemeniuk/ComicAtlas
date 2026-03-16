//
//  CharacterModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 16.03.2026.
//

import Foundation

nonisolated
struct CharactersResponse: Decodable {
    let characters: [CharacterModel]

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.characters = try container.decode([CharacterModel].self, forKey: .results)
    }
}

struct CharacterModel: Codable, Sendable {
    let id: Int
    let name: String
    let description: String
    let aliases: String
    let realName: String
    let image: ImageModel
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case aliases
        case realName = "real_name"
        case image
    }
}

struct ImageModel: Codable, Sendable {
    let iconUrl: String
    let smallUrl: String
    
    enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url"
        case smallUrl = "small_url"
    }
}
