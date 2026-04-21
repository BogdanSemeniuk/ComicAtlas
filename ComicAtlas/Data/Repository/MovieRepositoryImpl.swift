//
//  MovieRepositoryImpl.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

struct MovieRepositoryImpl: MovieRepository {
    let api: APIClientProtocol

    func fetchMovies(limit: Int, offset: Int, sort: SortDescriptor) async throws -> [Movie] {
        try await api.request(
            APIEndpoints.movies(limit: limit, offset: offset, sort: sort),
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
