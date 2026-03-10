//
//  RootView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 06.03.2026.
//

import SwiftUI

struct RootView: View {
    private let container: AppContainer
    @State private var authFlow: AuthFlowCoordinator
    @State private var homeFlow: HomeFlowCoordinator
    @State private var profileFlow: ProfileFlowCoordinator
    @State private var model: RootViewModel

    init(container: AppContainer = .shared) {
        self.container = container
        _authFlow = State(initialValue: AuthFlowCoordinator(container: container))
        _homeFlow = State(initialValue: HomeFlowCoordinator(container: container))
        _profileFlow = State(initialValue: ProfileFlowCoordinator(container: container))
        _model = State(initialValue: .init(authRepository: container.resolve()))
    }
    
    var body: some View {
        if let isAuthenticated = model.isAuthenticated {
            if isAuthenticated {
                TabBarView(
                    homeFlow: homeFlow,
                    profileFlow: profileFlow
                )
            } else {
                AuthFlowView(coordinator: authFlow)
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    RootView()
}
