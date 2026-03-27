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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let character = model.characterDetails {
                    header(for: character)
                    subheader(for: character)
                    description()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color(.background))
        .onAppear(perform: model.onAppear)
        
    }
    
    private var issues: some View {
        EmptyView()
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
            Text(deck)
                .font(.body.weight(.semibold))
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
                    headerTitle(character.name)
                    headerInfo(for: character)
                }
            }
        }
        .foregroundStyle(Color(.textSecondary))
    }
    
    private func headerTitle(_ title: String) -> some View {
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title.bold())
            .foregroundStyle(Color(.textPrimary))
    }
    
    private func headerInfo(for character: CharacterDetails) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if character.countOfIssueAppearances > 0 {
                HStack {
                    Text(.CharacterDetails.appearsInLabel)
                    LinkText(
                        destination: .init(safeString: character.siteDetailUrl)
                        .appending(pathComponent: .issues),
                        resource: .Common.issuesCount(Int32(character.countOfIssueAppearances)))
                }
            }
            if let gender = Gender(rawValue: character.gender)?.description {
                infoItem(.CharacterDetails.genderLabel, value: gender)
            }
            if let originName = character.originName {
                infoItem(.CharacterDetails.characterTypeLabel, value: originName)
            }
            if let publisherName = character.publisherName {
                infoItem(.Common.publisherLabel, value: publisherName)
            }
            LinkText(destination: .init(safeString: character.siteDetailUrl),
                     resource: .Common.openOnWeb)
        }
        .font(.default)
    }
    
    private func infoItem(_ label: LocalizedStringResource, value: String) -> some View {
        HStack(alignment: .center) {
            Text(label)
                .bold()
                .frame(width: 90, alignment: .leading)
            Text(value)
        }
    }
}

#Preview {
    CharacterDetailsView(
        viewModel: HomeFlowCoordinator(
            container: .shared
        ).makeCharacterDetailsViewModel(id: 1490)
    )
}
