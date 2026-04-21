//
//  CharacterRepositoryImpl.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 16.03.2026.
//

import Foundation

struct CharacterRepositoryImpl: CharacterRepository {
    let api: APIClientProtocol
    
    func fetchCharacters(limit: Int, offset: Int, sort: SortDescriptor) async throws -> [Character] {
        try await api.request(
            APIEndpoints.characters(limit: limit, offset: offset, sort: sort),
            as: CharactersResponse.self
        )
        .characters
        .map { .init(dto: .init($0)) }
    }
    
    func fetchCharacterDetails(id: Int) async throws -> CharacterDetails {
        let response = try await api.request(
            APIEndpoints.characterDetails(id: id),
            as: CharacterDetailsResponse.self
        )
        
        return .init(dto: .init(response.characterDetails))
    }
}
