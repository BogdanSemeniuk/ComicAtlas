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
                    case .details:
                        return Text("details")
                    }
                }
        }
    }
}

#Preview {
    HomeFlowView()
}
