//
//  LinkRouter.swift
//  ComicAtlas
//
//  Created by Codex on 31.03.2026.
//

import Combine
import Foundation

typealias LinkHandlingInfo = (url: URL, handleInApp: Bool)

protocol LinkRouting {
    var linkActions: AnyPublisher<LinkHandlingInfo, Never> { get }
    func route(url: URL, handleInApp: Bool)
}

final class LinkRouter: LinkRouting {
    var linkActions: AnyPublisher<LinkHandlingInfo, Never> {
        linkActionsPublisher.eraseToAnyPublisher()
    }

    private let linkActionsPublisher: PassthroughSubject<LinkHandlingInfo, Never> = .init()

    func route(url: URL, handleInApp: Bool = false) {
        guard url.scheme == nil else {
            linkActionsPublisher.send((url: url, handleInApp: true))
            return
        }

        linkActionsPublisher.send(
            (
                url: URL(safeString: AppEnvironment.baseURL).appending(path: url.absoluteString),
                handleInApp: handleInApp
            )
        )
    }
}
