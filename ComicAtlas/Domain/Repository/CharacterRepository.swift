//
//  CharacterRepository.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 16.03.2026.
//

import Foundation

protocol CharacterRepository {
    func fetchCharacters(limit: Int, offset: Int) async throws -> [Character]
}
