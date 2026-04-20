//
//  MovieDetailsModel.swift
//  ComicAtlas
//
//  Created by Codex on 31.03.2026.
//

import Foundation

nonisolated
struct MovieDetailsResponse: Decodable {
    let movieDetails: MovieDetailsModel

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movieDetails = try container.decode(MovieDetailsModel.self, forKey: .results)
    }
}

struct MovieDetailsModel: Codable, Sendable {
    let characters: [ReferenceModel]?
    let id: Int
    let name: String
    let budget: String?
    let deck: String?
    let description: String?
    let image: ImageModel
    let producers: [ReferenceModel]?
    let rating: String
    let releaseDate: String?
    let runtime: String
    let siteDetailUrl: String
    let studios: [ReferenceModel]?
    let totalRevenue: String?
    let writers: [ReferenceModel]?

    enum CodingKeys: String, CodingKey {
        case characters
        case id
        case name
        case budget
        case deck
        case description
        case image
        case producers
        case rating
        case releaseDate = "release_date"
        case runtime
        case siteDetailUrl = "site_detail_url"
        case studios
        case totalRevenue = "total_revenue"
        case writers
    }
}
