//
//  AuthFlowCoordinator.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 09.03.2026.
//

import SwiftUI

@Observable
final class AuthFlowCoordinator {
    enum Route: Hashable {
        case signUp
    }

    var path = [Route]()
    
    private(set) var signInViewModel: SignInViewModel!
    private let container: AppContainer
    
    init(container: AppContainer) {
        self.container = container
        self.signInViewModel = makeSignInViewModel()
    }
}

extension AuthFlowCoordinator: NavigationHandler {
    func navigate(to route: AnyHashable) {
        guard let route = route as? Route else { return }
        path.append(route)
    }
}

extension AuthFlowCoordinator {
    func makeSignInViewModel() -> SignInViewModel {
        .init(
            inputValidator: container.resolve(),
            authRepository: container.resolve(),
            navigationHandler: self
        )
    }
    
    func makeSignUpViewModel() -> SignUpViewModel {
        .init(
            inputValidator: container.resolve(),
            authRepository: container.resolve(),
            navigationHandler: self
        )
    }
}
