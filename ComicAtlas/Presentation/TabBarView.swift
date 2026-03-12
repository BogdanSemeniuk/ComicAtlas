//
//  TabBarView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import SwiftUI

struct TabBarView: View {
    @State private var selection: TabItem = .home
    
    var body: some View {
        TabView(selection: $selection) {
            Tab(
                .TabBar.home,
                systemImage: SystemImage.house.rawValue,
                value: .home
            ) {
                HomeFlowView()
            }
            Tab(
                .TabBar.profile,
                systemImage: SystemImage.personRectangle.rawValue,
                value: .profile
            ) {
                ProfileFlowView()
            }
        }
    }
    
    enum TabItem {
        case home
        case profile
    }
}

#Preview {
    TabBarView()
}
