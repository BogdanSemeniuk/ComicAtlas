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
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            if model.pickerSelection == .character {
                charactersGrid
            } else {
                table
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                CollectionPicker(selected: $model.pickerSelection)
            }
        }
        .onAppear(perform: model.onAppear)
    }
    
    private var table: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(model.cardsData) { cardData in
                    tableCrad(cardData)
                        .onAppear {
                            model.onAppear(card: cardData)
                        }
                }
            }
        }
    }
    
    private var charactersGrid: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 50, maximum: .infinity)),
                GridItem(.flexible(minimum: 50, maximum: .infinity))
            ], alignment: .center, spacing: 10) {
                ForEach(model.cardsData) { cardData in
                    characterCard(cardData)
                        .onAppear {
                            model.onAppear(card: cardData)
                        }
                }
            }
            .padding()
        }
    }
    
    // MARK: - Cards
    private func characterCard(_ cardData: CardData) -> some View {
        VStack(spacing: 0) {
            image(path: cardData.imageURL)
            Divider()
            title(text: cardData.title)
                .padding()
        }
        .background(Color(.background))
        .clipShape(Layout.componentShape)
        .overlay {
            Layout.componentShape
                .stroke(.border)
        }
        .appShadow()
    }
    
    func tableCrad(_ cardData: CardData) -> some View {
        HStack(alignment: .top, spacing: 10) {
            image(path: cardData.imageURL)
                .frame(width: 150)
            VStack(alignment: .leading, spacing: 10) {
                title(text: cardData.title)
                if let desctiption = cardData.desctiption {
                    Text(desctiption)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(Color(.textSecondary))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
        .overlay(alignment: .bottom) {
            Divider()
        }
    }
    
    // MARK: - UI Components
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
    
    private func title(text: String) -> some View {
        Text(text)
            .font(.title2.weight(.semibold))
            .lineLimit(2)
            .minimumScaleFactor(0.5)
            .foregroundStyle(.textPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func wrappedImage(_ image: Image = Image(.placeholder)) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    NavigationView {
        HomeView(
            model: HomeFlowCoordinator(container: .shared)
                .makeHomeViewModel()
        )
    }
}
