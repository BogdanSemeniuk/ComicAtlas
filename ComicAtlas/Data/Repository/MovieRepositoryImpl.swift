//
//  MovieRepositoryImpl.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

struct MovieRepositoryImpl: MovieRepository {
    let api: APIClientProtocol

    func fetchMovies(limit: Int, offset: Int) async throws -> [Movie] {
        try await api.request(
            APIEndpoints.movies(limit: limit, offset: offset),
            as: MoviesResponse.self
        )
        .movies
        .map { .init(dto: .init($0)) }
    }

    func fetchMovieDetails(id: Int) async throws -> MovieDetails {
        let response = try await api.request(
            APIEndpoints.movieDetails(id: id),
            as: MovieDetailsResponse.self
        )

        return .init(dto: .init(response.movieDetails))
    }
}
