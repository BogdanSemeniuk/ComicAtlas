//
//  MovieModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

nonisolated
struct MoviesResponse: Decodable {
    let movies: [MovieModel]

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movies = try container.decode([MovieModel].self, forKey: .results)
    }
}

struct MovieModel: Codable, Sendable {
    let id: Int
    let name: String
    let description: String?
    let releaseDate: String
    let image: ImageModel
    let studios: [StudioModel]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case releaseDate = "release_date"
        case image
        case studios
    }
}
