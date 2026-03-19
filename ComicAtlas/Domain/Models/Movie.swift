//
//  Movie.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

struct Movie: Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String?
    let releaseDate: String
    let iconUrl: String
    let smallUrl: String
    let studios: [String]

    init(dto: MovieDTO) {
        self.id = dto.id
        self.name = dto.name
        self.description = dto.description
        self.releaseDate = dto.releaseDate
        self.iconUrl = dto.iconUrl
        self.smallUrl = dto.smallUrl
        self.studios = dto.studios
    }
}
