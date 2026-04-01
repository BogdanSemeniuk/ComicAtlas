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
    func route(url: URL)
}

final class LinkRouter: LinkRouting {
    var linkActions: AnyPublisher<LinkHandlingInfo, Never> {
        linkActionsPublisher.eraseToAnyPublisher()
    }

    private let linkActionsPublisher: PassthroughSubject<LinkHandlingInfo, Never> = .init()
    
    func route(url: URL) {
        route(url: url, handleInApp: false)
    }

    func route(url: URL, handleInApp: Bool) {
        guard url.scheme == nil else {
            linkActionsPublisher.send((url: url, handleInApp: handleInApp))
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
