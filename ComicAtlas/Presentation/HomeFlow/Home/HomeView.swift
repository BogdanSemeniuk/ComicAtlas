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
        ScrollView {
            VStack {
                ForEach(model.characters) { character in
                    HStack {
                        AsyncImage(url: URL(string: character.smallUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Color.red
                        }
                        .frame(width: 200, height: 200)
                        
                        Text(character.name)
                    }
                }
            }
        }
        .onAppear(perform: model.onAppear)
    }
}
