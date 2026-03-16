//
//  CharacterRepositoryImpl.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 16.03.2026.
//

import Foundation

struct CharacterRepositoryImpl: CharacterRepository {
    let api: APIClientProtocol
    
    func fetchCharacters(limit: Int, offset: Int) async throws -> [Character] {
        try await api.request(
            APIEndpoints.characters(limit: limit, offset: offset),
            as: CharactersResponse.self
        )
        .characters
        .map { .init(dto: .init($0)) }
    }
}
