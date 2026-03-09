//
//  AuthFlowView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 09.03.2026.
//

import SwiftUI

struct AuthFlowView: View {
    @Bindable var coordinator: AuthFlowCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            SignInView(model: coordinator.signInVM)
                .navigationDestination(for: AuthFlowCoordinator.Route.self) { route in
                    switch route {
                    case .signUp:
                        Text("SignUp")
                    }
                }
        }
    }
}

#Preview {
    AuthFlowView(coordinator: .init(container: .shared))
}
