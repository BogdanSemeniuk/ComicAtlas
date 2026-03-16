//
//  CharacterDTO.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 16.03.2026.
//

import Foundation

struct CharacterDTO {
    let id: Int
    let name: String
    let description: String?
    let aliases: String?
    let realName: String?
    let iconUrl: String
    let smallUrl: String
    
    init(_ character: CharacterModel) {
        self.id = character.id
        self.name = character.name
        self.description = character.description
        self.aliases = character.aliases
        self.realName = character.realName
        self.iconUrl = character.image.smallUrl
        self.smallUrl = character.image.smallUrl
    }
}
