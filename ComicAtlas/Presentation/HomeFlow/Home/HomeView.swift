//
//  HomeView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import SwiftUI

struct HomeView: View {
    @Bindable var model: HomeViewModel
    @State private var scrollPositionID: String?
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            ScrollView {
                if model.pickerSelection == .character {
                    charactersGrid
                } else {
                    table
                }
            }
            .defaultScrollAnchor(.top)
            .scrollPosition(id: $scrollPositionID)
            .onScrollTargetVisibilityChange(idType: String.self) { identifiers in
                model.visibleItemsDidChange(identifiers)
            }
            .onChange(of: model.pendingScrollTargetID) { _, newValue in
                guard let newValue else { return }
                scrollPositionID = newValue
                model.didRestoreScrollPosition()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                CollectionPicker(selected: $model.pickerSelection)
            }
        }
        .onFirstAppear(model.onFirstAppear)
        .overlay {
            if model.isLoading {
                ProgressView()
                    .controlSize(.large)
            }
        }
    }
    
    private var table: some View {
        LazyVStack(spacing: 0) {
            ForEach(model.cardsData) { cardData in
                TableCard(cardData: cardData)
                    .padding()
                    .overlay(alignment: .bottom) {
                        Divider()
                    }
                    .onTapGesture {
                        model.selectCard(withData: cardData)
                    }
                    .onAppear {
                        model.onAppear(card: cardData)
                    }
                    .id(cardData.id)
            }
        }
        .scrollTargetLayout()
    }
    
    private var charactersGrid: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(minimum: 50, maximum: .infinity)),
            GridItem(.flexible(minimum: 50, maximum: .infinity))
        ], alignment: .center, spacing: 10) {
            ForEach(model.cardsData) { cardData in
                characterCard(cardData)
                    .onTapGesture {
                        model.selectCard(withData: cardData)
                    }
                    .onAppear {
                        model.onAppear(card: cardData)
                    }
                    .id(cardData.id)
            }
        }
        .padding()
        .scrollTargetLayout()
    }
    
    // MARK: - Cards
    private func characterCard(_ cardData: CardData) -> some View {
        VStack(spacing: 0) {
            RemoteImage(path: cardData.imageURL)
            Divider()
            CardTitle(text: cardData.title)
                .padding()
        }
        .contentShape(.rect)
        .background(Color(.background))
        .clipShape(Layout.componentShape)
        .overlay {
            Layout.componentShape
                .stroke(.border)
        }
        .appShadow()
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
