//
//  HomeFlowView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 12.03.2026.
//

import SwiftUI

struct HomeFlowView: View {
    @State private var coordinator = HomeFlowCoordinator(container: .shared)
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HomeView(model: coordinator.homeViewModel)
                .navigationDestination(for: HomeFlowCoordinator.Route.self) { route in
                    switch route {
                    case .character(let id):
                        CharacterDetailsView(
                            viewModel: coordinator.makeCharacterDetailsViewModel(id: id)
                        )
                    case .issue(let id):
                        IssueDetailsView(
                            viewModel: coordinator.makeIssueDetailsViewModel(id: id)
                        )
                    }
                }
        }
    }
}

#Preview {
    HomeFlowView()
}
