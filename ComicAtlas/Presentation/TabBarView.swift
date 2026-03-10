//
//  TabBarView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import SwiftUI

struct TabBarView: View {
    @State private var selection: TabItem = .home
    @Bindable var homeFlow: HomeFlowCoordinator
    @Bindable var profileFlow: ProfileFlowCoordinator
    
    var body: some View {
        TabView(selection: $selection) {
            Tab(
                .TabBar.home,
                systemImage: SystemImage.house.rawValue,
                value: .home
            ) {
                HomeView(model: homeFlow.homeViewModel)
            }
            Tab(
                .TabBar.profile,
                systemImage: SystemImage.personRectangle.rawValue,
                value: .profile
            ) {
                ProfileView(model: profileFlow.profileViewModel)
            }
        }
    }
    
    enum TabItem {
        case home
        case profile
    }
}

#Preview {
    TabBarView(
        homeFlow: .init(container: .shared),
        profileFlow: .init(container: .shared)
    )
}
