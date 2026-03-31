//
//  HomeFlowCoordinator.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import Foundation

@Observable
final class HomeFlowCoordinator {
    enum Route: Hashable {
        case character(id: Int)
        case volume(id: Int)
        case issue(id: Int)
        case movie(id: Int)
    }

    var path = [Route]()
    
    private(set) var homeViewModel: HomeViewModel!
    private let container: AppContainer
    
    init(container: AppContainer) {
        self.container = container
        self.homeViewModel = makeHomeViewModel()
    }
}

extension HomeFlowCoordinator: NavigationHandler {
    func navigate(to route: AnyHashable) {
        guard let route = route as? Route else { return }
        path.append(route)
    }
}

extension HomeFlowCoordinator {
    func makeHomeViewModel() -> HomeViewModel {
        .init(
            characterRepository: container.resolve(),
            volumesRepository: container.resolve(),
            issueRepository: container.resolve(),
            movieRepository: container.resolve(),
            navigationHandler: self
        )
    }
    
    func makeCharacterDetailsViewModel(id: Int) -> CharacterDetailsViewModel {
        .init(
            id: id,
            characterRepository: container.resolve(),
            issueRepository: container.resolve(),
            htmlDecorator: container.resolve(),
            navigationHandler: self
        )
    }
    
    func makeIssueDetailsViewModel(id: Int) -> IssueDetailsViewModel {
        .init(
            id: id,
            issueRepository: container.resolve(),
            characterRepository: container.resolve(),
            volumeRepository: container.resolve(),
            htmlDecorator: container.resolve(),
            navigationHandler: self
        )
    }

    func makeVolumeDetailsViewModel(id: Int) -> VolumeDetailsViewModel {
        .init(
            id: id,
            volumeRepository: container.resolve(),
            issueRepository: container.resolve(),
            htmlDecorator: container.resolve(),
            navigationHandler: self
        )
    }

    func makeMovieDetailsViewModel(id: Int) -> MovieDetailsViewModel {
        .init(
            id: id,
            movieRepository: container.resolve(),
            characterRepository: container.resolve(),
            htmlDecorator: container.resolve()
        )
    }
}
