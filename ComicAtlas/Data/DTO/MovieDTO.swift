//
//  MovieDTO.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

struct MovieDTO {
    let id: Int
    let name: String
    let description: String?
    let releaseDate: String
    let iconUrl: String
    let smallUrl: String
    var studios: [String] = []

    init(_ movie: MovieModel) {
        self.id = movie.id
        self.name = movie.name
        self.description = movie.description
        self.releaseDate = movie.releaseDate
        self.iconUrl = movie.image.iconUrl
        self.smallUrl = movie.image.smallUrl
        guard let studios = movie.studios else { return }
        self.studios = studios.map(\.name)
    }
}
