//
//  CharacterDetailsViewModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 24.03.2026.
//

import SwiftUI

@Observable
class CharacterDetailsViewModel {
    var isLoading = false
    var characterDetails: CharacterDetails?
    var error: Error?
    var htmlContent: String?
    var webViewHeight: CGFloat = 500
    private let id: Int
    private let characterRepository: CharacterRepository
    private let htmlDecorator: any HTMLFormatting
    private let navigationHandler: any NavigationHandler
    
    init(
        id: Int,
        characterRepository: CharacterRepository,
        htmlDecorator: any HTMLFormatting,
        navigationHandler: any NavigationHandler
    ) {
        self.id = id
        self.characterRepository = characterRepository
        self.htmlDecorator = htmlDecorator
        self.navigationHandler = navigationHandler
    }
    
    func onAppear() {
        guard characterDetails == nil, !isLoading else { return }
        fetchCharacterDetails()
    }
    
    func linkAction(url: URL) {
    }
    
    func webViewContentHeightDidChange(_ height: CGFloat) {
        webViewHeight = height
    }
    
    func fetchCharacterDetails() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            defer { isLoading = false }
            
            do {
                characterDetails = try await characterRepository.fetchCharacterDetails(id: id)
                guard let description = characterDetails?.description else { return }
                htmlContent = htmlDecorator.decorate(html: description, fontSize: 16)
            } catch {
                self.error = error
            }
        }
    }
}
