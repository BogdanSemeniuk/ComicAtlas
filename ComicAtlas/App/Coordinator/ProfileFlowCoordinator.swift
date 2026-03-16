//
//  ProfileFlowCoordinator.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import Foundation

@Observable
final class ProfileFlowCoordinator {
    enum Route: Hashable {
    }

    var path = [Route]()
    
    private(set) var profileViewModel: ProfileViewModel!
    private let container: AppContainer
    
    init(container: AppContainer) {
        self.container = container
        self.profileViewModel = makeProfileViewModel()
    }
}

extension ProfileFlowCoordinator: NavigationHandler {
    func navigate(to route: AnyHashable) {
        guard let route = route as? Route else { return }
        path.append(route)
    }
}

extension ProfileFlowCoordinator {
    func makeProfileViewModel() -> ProfileViewModel {
        .init(
            authRepository: container.resolve()
        )
    }
}
