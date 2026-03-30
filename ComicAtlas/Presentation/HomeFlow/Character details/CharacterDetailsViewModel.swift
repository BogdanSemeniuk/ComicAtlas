//
//  CharacterDetailsViewModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 24.03.2026.
//

import Combine
import SwiftUI

typealias LinkHandlingInfo = (url: URL, handleInApp: Bool)

@Observable
class CharacterDetailsViewModel {
    var isLoading = false
    var characterDetails: CharacterDetails?
    var error: Error?
    var htmlContent: String?
    var issuePreviews = [ItemPreview]()
    var webViewHeight: CGFloat = 200
    var linkActions: AnyPublisher<LinkHandlingInfo, Never> { linkActionsPublisher.eraseToAnyPublisher() }
    private var linkActionsPublisher: PassthroughSubject<LinkHandlingInfo, Never> = .init()
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
        guard url.scheme == nil else {
            linkActionsPublisher.send((url: url, handleInApp: true))
            return
        }
        linkActionsPublisher
            .send(
                (url: URL(safeString: AppEnvironment.baseURL).appending(path: url.absoluteString),
                 handleInApp: false)
            )
    }
    
    func openIssue(id: Int) {
        navigationHandler.navigate(to: HomeFlowCoordinator.NavigationRoute.issue(id: id))
    }
    
    func webViewContentHeightDidChange(_ height: CGFloat) {
        webViewHeight = height
    }
    
    func fetchCharacterDetails() {
        isLoading = true
        
        Task {
            defer { isLoading = false }
            
            do {
                characterDetails = try await characterRepository.fetchCharacterDetails(id: id)
                issuePreviews = try await fetchIssuesImages()
                guard let description = characterDetails?.description else { return }
                htmlContent = htmlDecorator.decorate(html: description, fontSize: 16)
            } catch {
                self.error = error
            }
        }
    }
    
    private func fetchIssuesImages() async throws -> [ItemPreview] {
        guard let characterDetails else { return [] }
        return try await withThrowingTaskGroup(of: ItemPreview.self) { [weak self] group in
            guard let self else { return [] }
            for issueCredit in characterDetails.issueCredits.prefix(5) {
                group.addTask {
                    let issue = try await self.issueRepository.fetchIssueDetails(id: issueCredit.id)
                    return .init(id: issue.id, title: issue.name ?? "", imagePath: issue.smallUrl)
                }
            }
            var result = [ItemPreview]()
            for try await preview in group {
                result.append(preview)
            }
            return result
        }
    }
}
