//
//  CharacterDetailsViewModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 24.03.2026.
//

import Foundation

@Observable
class CharacterDetailsViewModel {
    var isLoading = false
    var characterDetails: CharacterDetails?
    var error: Error?
    
    private let id: Int
    private let characterRepository: CharacterRepository
    private let navigationHandler: any NavigationHandler
    
    init(
        id: Int,
        characterRepository: CharacterRepository,
        navigationHandler: any NavigationHandler
    ) {
        self.id = id
        self.characterRepository = characterRepository
        self.navigationHandler = navigationHandler
    }
    
    func onAppear() {
        guard characterDetails == nil, !isLoading else { return }
        fetchCharacterDetails()
    }
    
    func fetchCharacterDetails() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            defer { isLoading = false }
            
            do {
                characterDetails = try await characterRepository.fetchCharacterDetails(id: id)
            } catch {
                self.error = error
                print(error)
            }
        }
    }
}
