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

    var path = NavigationPath()
    var view: some View {
        AuthFlowView(coordinator: self)
    }
    
    private(set) var signInVM: SignInViewModel!
    private let container: AppContainer
    
    init(container: AppContainer) {
        self.container = container
        self.signInVM = makeSignInViewModel()
    }
}

extension AuthFlowCoordinator: NavigationHandler {
    func navigate(to route: AnyHashable) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}

extension AuthFlowCoordinator {
    func makeSignInViewModel() -> SignInViewModel {
        .init(
            inputValidator: container.resolve(),
            authRepository: container.resolve(),
            navigation: self
        )
    }
}
