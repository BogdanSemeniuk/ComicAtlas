//
//  IssueDetailsViewModel.swift
//  ComicAtlas
//
//  Created by Codex on 27.03.2026.
//

import Combine
import SwiftUI

@Observable
final class IssueDetailsViewModel {
    typealias NetworkingResult = ([ItemPreview], VolumeDetails)
    
    var isLoading = false
    var issueDetails: IssueDetails?
    var volumeDetails: VolumeDetails?
    var error: Error?
    var htmlContent: String?
    var characterPreviews = [ItemPreview]()
    var webViewHeight: CGFloat = 200
    var linkActions: AnyPublisher<LinkHandlingInfo, Never> { linkActionsPublisher.eraseToAnyPublisher() }
    
    private var linkActionsPublisher: PassthroughSubject<LinkHandlingInfo, Never> = .init()
    private let id: Int
    private let issueRepository: IssueRepository
    private let characterRepository: CharacterRepository
    private let volumeRepository: VolumeRepository
    private let htmlDecorator: any HTMLFormatting
    private let navigationHandler: any NavigationHandler
    
    init(
        id: Int,
        issueRepository: IssueRepository,
        characterRepository: CharacterRepository,
        volumeRepository: VolumeRepository,
        htmlDecorator: any HTMLFormatting,
        navigationHandler: any NavigationHandler
    ) {
        self.id = id
        self.issueRepository = issueRepository
        self.characterRepository = characterRepository
        self.volumeRepository = volumeRepository
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
                let issueDetails = try await issueRepository.fetchIssueDetails(id: id)
                async let characterPreviews = fetchCharacterPreviews()
                async let volumeDetails = fetchVolumeDetails(for: issueDetails)
                let result: NetworkingResult = try await (characterPreviews, volumeDetails)
                self.issueDetails = issueDetails
                self.characterPreviews = result.0
                self.volumeDetails = result.1
                guard let description = self.issueDetails?.description else { return }
                htmlContent = htmlDecorator.decorate(html: description, fontSize: 16)
            } catch {
                self.error = error
            }
        }
    }
    
    func openVolume(id: Int) {
        navigationHandler.navigate(to: HomeFlowCoordinator.NavigationRoute.volume(id: id))
    }
    
    private func fetchVolumeDetails(for issue: IssueDetails) async throws -> VolumeDetails {
        try await volumeRepository.fetchVolumeDetails(id: issue.volume.id)
    }
    
    private func fetchCharacterPreviews() async throws -> [ItemPreview] {
        guard let issueDetails else { return [] }
        
        return try await withThrowingTaskGroup(of: ItemPreview.self) { [weak self] group in
            guard let self else { return [] }
            
            for character in issueDetails.characterCredits {
                group.addTask {
                    let characterDetails = try await self.characterRepository.fetchCharacterDetails(id: character.id)
                    return .init(
                        id: character.id,
                        title: characterDetails.name,
                        imagePath: characterDetails.iconUrl
                    )
                }
            }
            
            var characters = [ItemPreview]()
            for try await character in group {
                characters.append(character)
            }
            return characters
        }
    }
}
