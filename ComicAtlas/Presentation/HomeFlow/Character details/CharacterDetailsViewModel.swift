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
    var issuesImages = [String]()
    var webViewHeight: CGFloat = 200
    private let id: Int
    private let characterRepository: CharacterRepository
    private let issueRepository: IssueRepository
    private let htmlDecorator: any HTMLFormatting
    private let navigationHandler: any NavigationHandler
    
    init(
        id: Int,
        characterRepository: CharacterRepository,
        issueRepository: IssueRepository,
        htmlDecorator: any HTMLFormatting,
        navigationHandler: any NavigationHandler
    ) {
        self.id = id
        self.characterRepository = characterRepository
        self.issueRepository = issueRepository
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
                issuesImages = try await fetchIssuesImages()
                guard let description = characterDetails?.description else { return }
                htmlContent = htmlDecorator.decorate(html: description, fontSize: 16)
            } catch {
                self.error = error
            }
        }
    }
    
    private func fetchIssuesImages() async throws -> [String] {
        guard let characterDetails else { return [] }
        return try await withThrowingTaskGroup(of: String.self) { [weak self] group in
            guard let self else { return [] }
            for issueCredit in characterDetails.issueCredits.prefix(5) {
                group.addTask {
                    try await self.issueRepository.fetchIssueDetails(id: issueCredit.id).smallUrl
                }
            }
            var images = [String]()
            for try await image in group {
                images.append(image)
            }
            return images
        }
    }
}
