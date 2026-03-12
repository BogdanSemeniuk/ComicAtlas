//
//  ProfileFlowView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 12.03.2026.
//

import SwiftUI

struct ProfileFlowView: View {
    @State private var coordinator = ProfileFlowCoordinator(container: .shared)
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ProfileView(model: coordinator.profileViewModel)
                .navigationDestination(for: ProfileFlowCoordinator.Route.self) { route in
                    
                }
        }
    }
}
