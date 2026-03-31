//
//  MovieDetailsView.swift
//  ComicAtlas
//
//  Created by Codex on 31.03.2026.
//

import SwiftUI

struct MovieDetailsView: View {
    @State private var model: MovieDetailsViewModel

    @Environment(\.openURL)
    private var openURL

    init(viewModel: MovieDetailsViewModel) {
        _model = State(initialValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let movie = model.movieDetails {
                    header(for: movie)
                    deck(for: movie)
                    characters()
                    description()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color(.background))
        .overlay {
            if model.isLoading {
                ProgressView()
                    .controlSize(.large)
            }
        }
        .animation(.smooth, value: model.movieDetails)
        .onAppear(perform: model.onAppear)
        .onReceive(model.linkActions) { linkHandlingInfo in
            openURL(
                linkHandlingInfo.url,
                prefersInApp: linkHandlingInfo.handleInApp
            )
        }
    }

    private func header(for movie: MovieDetails) -> some View {
        HStack(alignment: .top, spacing: 16) {
            RemoteImage(
                path: movie.smallUrl,
                backgroundColor: .clear
            )
            .frame(width: 150)
            .overlay {
                Layout.componentShape
                    .stroke(Color(.border))
            }

            VStack(alignment: .leading, spacing: 16) {
                HeaderTitle(text: movie.name)
                headerInfo(for: movie)
            }
        }
        .foregroundStyle(Color(.textSecondary))
    }

    @ViewBuilder
    private func deck(for movie: MovieDetails) -> some View {
        if let deck = movie.deck {
            Deck(text: deck)
        }
    }

    @ViewBuilder
    private func characters() -> some View {
        if !model.characterPreviews.isEmpty {
            CharactersSection(
                title: .MovieDetails.charactersLabel,
                previews: model.characterPreviews,
                onTap: model.characterAction
            )
        }
    }

    @ViewBuilder
    private func description() -> some View {
        if let html = model.htmlContent {
            AppWebView(
                html: html,
                webViewHeight: model.webViewHeight,
                onTapLink: { model.linkAction(url: $0) },
                contentHeightCompletion: { model.webViewContentHeightDidChange($0) }
            )
        }
    }

    private func headerInfo(for movie: MovieDetails) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            InfoItem(
                label: .MovieDetails.releaseDateLabel,
                value: model.formattedReleaseDate(for: movie)
            )
            InfoItem(label: .MovieDetails.ratingLabel, value: movie.rating)

            let studios = model.studiosText(for: movie)
            if !studios.isEmpty {
                InfoItem(label: .MovieDetails.studiosLabel, value: studios)
            }
            
            if let budget = model.formattedBudget(for: movie) {
                InfoItem(label: .MovieDetails.budgetLabel, value: budget)
            }

            if let totalRevenue = model.formattedRevenue(for: movie) {
                InfoItem(label: .MovieDetails.totalRevenueLabel, value: totalRevenue)
            }

            LinkText(
                destination: .init(safeString: movie.siteDetailUrl),
                resource: .Common.openOnWeb
            )
        }
        .font(.default)
    }
}

#Preview {
    MovieDetailsView(
        viewModel: HomeFlowCoordinator(
            container: .shared
        ).makeMovieDetailsViewModel(id: 1)
    )
}
