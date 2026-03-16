//
//  Character.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 16.03.2026.
//

import Foundation

struct Character: Identifiable {
    let id: Int
    let name: String
    let description: String?
    let aliases: String?
    let realName: String?
    let iconUrl: String
    let smallUrl: String
    
    init(dto: CharacterDTO) {
        self.id = dto.id
        self.name = dto.name
        self.description = dto.description
        self.aliases = dto.aliases
        self.realName = dto.realName
        self.iconUrl = dto.iconUrl
        self.smallUrl = dto.smallUrl
    }
}
