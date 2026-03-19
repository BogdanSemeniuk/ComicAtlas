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
        case details
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
            volumesRepository: container.resolve()
        )
    }
}
