//
//  HomeViewModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import Foundation

@Observable
class HomeViewModel {
    var isLoading = false
    var characters = [Character]()
    private let characterRepository: CharacterRepository
    
    init(
        characterRepository: CharacterRepository,
    ) {
        self.characterRepository = characterRepository
    }
    
    func onAppear() {
        Task {
            isLoading = true
            do {
                characters = try await characterRepository.fetchCharacters(limit: 10, offset: 0)
            } catch {
                print(error)
            }
            isLoading = false
        }
    }
}
