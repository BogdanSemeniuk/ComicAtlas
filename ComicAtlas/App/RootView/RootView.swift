//
//  RootView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 06.03.2026.
//

import SwiftUI

struct RootView: View {
    private let container: AppContainer
    @State private var model: RootViewModel

    init(container: AppContainer = .shared) {
        self.container = container
        _model = State(initialValue: .init(authRepository: container.resolve()))
    }
    
    var body: some View {
        if let isAuthenticated = model.isAuthenticated {
            if isAuthenticated {
                TabBarView()
            } else {
                AuthFlowView()
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    RootView()
}
