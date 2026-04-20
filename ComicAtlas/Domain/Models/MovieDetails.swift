//
//  MovieDetails.swift
//  ComicAtlas
//
//  Created by Codex on 31.03.2026.
//

import Foundation

struct MovieDetails: Identifiable, Hashable {
    let characters: [Reference]
    let id: Int
    let name: String
    let budget: String?
    let deck: String?
    let description: String?
    let producers: [Reference]
    let rating: String
    let releaseDate: String?
    let runtime: String
    let siteDetailUrl: String
    let studios: [Reference]
    let totalRevenue: String?
    let writers: [Reference]
    let iconUrl: String
    let smallUrl: String

    init(dto: MovieDetailsDTO) {
        self.characters = dto.characters.map { .init(dto: $0) }
        self.id = dto.id
        self.name = dto.name
        self.budget = dto.budget
        self.deck = dto.deck
        self.description = dto.description
        self.producers = dto.producers.map { .init(dto: $0) }
        self.rating = dto.rating
        self.releaseDate = dto.releaseDate
        self.runtime = dto.runtime
        self.siteDetailUrl = dto.siteDetailUrl
        self.studios = dto.studios.map { .init(dto: $0) }
        self.totalRevenue = dto.totalRevenue
        self.writers = dto.writers.map { .init(dto: $0) }
        self.iconUrl = dto.iconUrl
        self.smallUrl = dto.smallUrl
    }
}
