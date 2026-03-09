//
//  RootView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 06.03.2026.
//

import FirebaseAuth
import SwiftUI

struct RootView: View {
    private let container: AppContainer
    @State private var authFlow: AuthFlowCoordinator

    init(container: AppContainer = .shared) {
        self.container = container
        _authFlow = State(initialValue: AuthFlowCoordinator(container: container))
    }
    
    var body: some View {
        authFlow.view
    }
}

#Preview {
    RootView()
}
