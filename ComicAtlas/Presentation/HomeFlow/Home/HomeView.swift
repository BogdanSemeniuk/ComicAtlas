//
//  HomeView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import SwiftUI

struct HomeView: View {
    @State private var model: HomeViewModel
    
    init(model: HomeViewModel) {
        self._model = State(initialValue: model)
    }
    
    var body: some View {
        Picker("What is your favorite color?", selection: $model.favoriteColor) {
            ForEach(model.colors, id: \.self) { color in
                Text(color).tag(color)
            }
        }
        .pickerStyle(.segmented)
        .onAppear(perform: model.onAppear)
    }
}
