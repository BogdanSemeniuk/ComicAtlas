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
        VStack {
            Text(model.characterDetails?.name ?? "Loading")
            if let imageURL = model.characterDetails?.iconUrl {
                image(path: imageURL)
            }
        }
        .onAppear(perform: model.onAppear)
    }
    
    private func image(path: String) -> some View {
        AsyncImage(url: URL(string: path)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                wrappedImage(image)
            case .failure:
                wrappedImage()
            default:
                Color.red
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(.white)
    }
    
    private func wrappedImage(_ image: Image = Image(.placeholder)) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    CharacterDetailsView(
        viewModel: HomeFlowCoordinator(
            container: .shared
        ).makeCharacterDetailsViewModel(id: 0)
    )
}
