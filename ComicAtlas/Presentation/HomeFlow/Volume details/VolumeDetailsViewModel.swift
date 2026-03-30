//
//  VolumeDetailsViewModel.swift
//  ComicAtlas
//
//  Created by Codex on 30.03.2026.
//

import Combine
import SwiftUI

@Observable
final class VolumeDetailsViewModel {
    var isLoading = false
    var volumeDetails: VolumeDetails?
    var error: Error?
    var htmlContent: String?
    var issuePreviews = [ItemPreview]()
    var webViewHeight: CGFloat = 200
    var linkActions: AnyPublisher<LinkHandlingInfo, Never> { linkActionsPublisher.eraseToAnyPublisher() }

    private var linkActionsPublisher: PassthroughSubject<LinkHandlingInfo, Never> = .init()
    private let id: Int
    private let volumeRepository: VolumeRepository
    private let issueRepository: IssueRepository
    private let htmlDecorator: any HTMLFormatting
    private let navigationHandler: any NavigationHandler

    init(
        id: Int,
        volumeRepository: VolumeRepository,
        issueRepository: IssueRepository,
        htmlDecorator: any HTMLFormatting,
        navigationHandler: any NavigationHandler
    ) {
        self.id = id
        self.volumeRepository = volumeRepository
        self.issueRepository = issueRepository
        self.htmlDecorator = htmlDecorator
        self.navigationHandler = navigationHandler
    }

    func onAppear() {
        guard volumeDetails == nil, !isLoading else { return }
        fetchVolumeDetails()
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

    func openIssueDetails(id: Int) {
        navigationHandler.navigate(to: HomeFlowCoordinator.Route.issue(id: id))
    }

    func webViewContentHeightDidChange(_ height: CGFloat) {
        webViewHeight = height
    }

    func fetchVolumeDetails() {
        isLoading = true

        Task {
            defer { isLoading = false }

            do {
                let volumeDetails = try await volumeRepository.fetchVolumeDetails(id: id)
                self.volumeDetails = volumeDetails
                self.issuePreviews = try await fetchIssuePreviews(for: volumeDetails)

                guard let description = volumeDetails.description else { return }
                htmlContent = htmlDecorator.decorate(html: description, fontSize: 16)
            } catch {
                self.error = error
            }
        }
    }

    private func fetchIssuePreviews(for volumeDetails: VolumeDetails) async throws -> [ItemPreview] {
        var previews = [ItemPreview]()

        for issueReference in volumeDetails.issues.prefix(5) {
            let issue = try await issueRepository.fetchIssueDetails(id: issueReference.id)

            previews.append(
                .init(
                    id: issueReference.id,
                    title: issue.title,
                    imagePath: issue.smallUrl
                )
            )
        }

        return previews
    }
}
