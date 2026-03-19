//
//  MovieRepository.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

protocol MovieRepository {
    func fetchMovies(limit: Int, offset: Int) async throws -> [Movie]
}
