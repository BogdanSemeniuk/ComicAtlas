//
//  HomeView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import SwiftUI

struct HomeView: View {
    @Bindable var model: HomeViewModel
    
    var body: some View {
        VStack {
            ForEach(model.characters) { character in
                Text(character.name)
            }
        }
        .onAppear(perform: model.onAppear)
    }
}
