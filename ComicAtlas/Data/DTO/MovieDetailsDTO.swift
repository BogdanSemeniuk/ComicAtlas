//
//  MovieDetailsDTO.swift
//  ComicAtlas
//
//  Created by Codex on 31.03.2026.
//

import Foundation

struct MovieDetailsDTO {
    let characters: [ReferenceDTO]
    let id: Int
    let name: String
    let budget: String?
    let deck: String?
    let description: String?
    let producers: [ReferenceDTO]
    let rating: String
    let releaseDate: String?
    let runtime: String
    let siteDetailUrl: String
    let studios: [ReferenceDTO]
    let totalRevenue: String?
    let writers: [ReferenceDTO]
    let iconUrl: String
    let smallUrl: String

    init(_ movieDetails: MovieDetailsModel) {
        self.characters = movieDetails.characters?.map { .init($0) } ?? []
        self.id = movieDetails.id
        self.name = movieDetails.name
        self.budget = movieDetails.budget
        self.deck = movieDetails.deck
        self.description = movieDetails.description
        self.producers = movieDetails.producers?.map { .init($0) } ?? []
        self.rating = movieDetails.rating
        self.releaseDate = movieDetails.releaseDate
        self.runtime = movieDetails.runtime
        self.siteDetailUrl = movieDetails.siteDetailUrl
        self.studios = movieDetails.studios?.map { .init($0) } ?? []
        self.totalRevenue = movieDetails.totalRevenue
        self.writers = movieDetails.writers?.map { .init($0) } ?? []
        self.iconUrl = movieDetails.image.iconUrl
        self.smallUrl = movieDetails.image.smallUrl
    }
}
