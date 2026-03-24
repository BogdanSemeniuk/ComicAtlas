//
//  CharacterDetailsView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 24.03.2026.
//

import SwiftUI

struct CharacterDetailsView: View {
    @State private var model: CharacterDetailsViewModel
    
    init(viewModel: CharacterDetailsViewModel) {
        _model = State(initialValue: viewModel)
    }
    
    var body: some View {
        Text("CharacterDetailsViewModel")
    }
}

#Preview {
    CharacterDetailsView(
        viewModel: HomeFlowCoordinator(
            container: .shared
        ).makeCharacterDetailsViewModel(id: 0)
    )
}
