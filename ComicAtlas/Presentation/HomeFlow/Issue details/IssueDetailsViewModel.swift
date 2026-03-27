//
//  IssueDetailsViewModel.swift
//  ComicAtlas
//
//  Created by Codex on 27.03.2026.
//

import Combine
import SwiftUI

@MainActor
@Observable
final class IssueDetailsViewModel {
    struct CharacterPreview: Identifiable, Hashable {
        let id: Int
        let name: String
        let imagePath: String
    }
    
    var isLoading = false
    var issueDetails: IssueDetails?
    var error: Error?
    var htmlContent: String?
    var characterPreviews = [CharacterPreview]()
    var webViewHeight: CGFloat = 200
    var linkActions: AnyPublisher<LinkHandlingInfo, Never> { linkActionsPublisher.eraseToAnyPublisher() }
    
    private var linkActionsPublisher: PassthroughSubject<LinkHandlingInfo, Never> = .init()
    private let id: Int
    private let issueRepository: IssueRepository
    private let characterRepository: CharacterRepository
    private let htmlDecorator: any HTMLFormatting
    private let navigationHandler: any NavigationHandler
    
    init(
        id: Int,
        issueRepository: IssueRepository,
        characterRepository: CharacterRepository,
        htmlDecorator: any HTMLFormatting,
        navigationHandler: any NavigationHandler
    ) {
        self.id = id
        self.issueRepository = issueRepository
        self.characterRepository = characterRepository
        self.htmlDecorator = htmlDecorator
        self.navigationHandler = navigationHandler
    }
    
    func onAppear() {
        guard issueDetails == nil, !isLoading else { return }
        fetchIssueDetails()
    }
    
    func linkAction(url: URL) {
        guard url.scheme == nil else {
            linkActionsPublisher.send((url: url, handleInApp: true))
            return
        }
        linkActionsPublisher.send(
            (
                url: URL(safeString: AppEnvironment.baseURL).appending(path: url.absoluteString),
                handleInApp: false
            )
        )
    }
    
    func webViewContentHeightDidChange(_ height: CGFloat) {
        webViewHeight = height
    }
    
    func fetchIssueDetails() {
        isLoading = true
        
        Task {
            defer { isLoading = false }
            
            do {
                issueDetails = try await issueRepository.fetchIssueDetails(id: id)
                characterPreviews = try await fetchCharacterPreviews()
                guard let description = issueDetails?.description else { return }
                htmlContent = htmlDecorator.decorate(html: description, fontSize: 16)
            } catch {
                self.error = error
            }
        }
    }
    
    private func fetchCharacterPreviews() async throws -> [CharacterPreview] {
        guard let issueDetails else { return [] }
        
        return try await withThrowingTaskGroup(of: CharacterPreview.self) { [weak self] group in
            guard let self else { return [] }
            
            for character in issueDetails.characterCredits {
                group.addTask {
                    let characterDetails = try await self.characterRepository.fetchCharacterDetails(id: character.id)
                    return .init(
                        id: character.id,
                        name: characterDetails.name,
                        imagePath: characterDetails.iconUrl
                    )
                }
            }
            
            var characters = [CharacterPreview]()
            for try await character in group {
                characters.append(character)
            }
            return characters
        }
    }
}
