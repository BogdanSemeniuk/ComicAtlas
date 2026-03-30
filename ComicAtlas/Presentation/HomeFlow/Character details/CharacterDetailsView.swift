//
//  CharacterDetailsView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 24.03.2026.
//

import SwiftUI

struct CharacterDetailsView: View {
    @State private var model: CharacterDetailsViewModel
    @Environment(\.openURL)
    private var openURL
    
    init(viewModel: CharacterDetailsViewModel) {
        _model = State(initialValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let character = model.characterDetails {
                    header(for: character)
                    subheader(for: character)
                    issues(for: character)
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
        .animation(.smooth, value: model.characterDetails)
        .onAppear(perform: model.onAppear)
        .onReceive(model.linkActions) { linkHandlingInfo in
            openURL(
                linkHandlingInfo.url,
                prefersInApp: linkHandlingInfo.handleInApp
            )
        }
    }
    
    private func issues(for character: CharacterDetails) -> some View {
        VStack(alignment: .leading) {
            Divider()
            HStack {
                Text(.CharacterDetails.appearsInLabel)
                    .foregroundStyle(Color(.textSecondary))
                LinkText(
                    destination: .init(safeString: character.siteDetailUrl)
                    .appending(pathComponent: .issues),
                    resource: .Common.issuesCount(Int32(character.countOfIssueAppearances))
                )
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(model.issuePreviews, id: \.self) { preview in
                        RemoteImage(path: preview.imagePath)
                            .frame(width: 150)
                            .onTapGesture {
                                model.openIssue(id: preview.id)
                            }
                    }
                }
            }
            Divider()
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
    
    @ViewBuilder
    private func subheader(for character: CharacterDetails) -> some View {
        if let deck = character.deck {
            Deck(text: deck)
        }
    }
    
    private func header(for character: CharacterDetails) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                RemoteImage(
                    path: character.smallUrl,
                    backgroundColor: .clear
                )
                .frame(width: 150)
                .overlay {
                    Layout.componentShape
                        .stroke(Color(.border))
                }
                VStack(alignment: .leading, spacing: 16) {
                    HeaderTitle(text: character.name)
                    headerInfo(for: character)
                }
            }
        }
        .foregroundStyle(Color(.textSecondary))
    }
    
    private func headerInfo(for character: CharacterDetails) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if let gender = Gender(rawValue: character.gender)?.description {
                InfoItem(label: .CharacterDetails.genderLabel, value: gender)
            }
            if let originName = character.originName {
                InfoItem(label: .CharacterDetails.characterTypeLabel, value: originName)
            }
            if let publisherName = character.publisherName {
                InfoItem(label: .Common.publisherLabel, value: publisherName)
            }
            LinkText(destination: .init(safeString: character.siteDetailUrl),
                     resource: .Common.openOnWeb)
        }
        .font(.default)
    }
}

#Preview {
    CharacterDetailsView(
        viewModel: HomeFlowCoordinator(
            container: .shared
        ).makeCharacterDetailsViewModel(id: 1490)
    )
}
