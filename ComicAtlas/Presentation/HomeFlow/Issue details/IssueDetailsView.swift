//
//  IssueDetailsView.swift
//  ComicAtlas
//
//  Created by Codex on 27.03.2026.
//

import SwiftUI

struct IssueDetailsView: View {
    @State private var model: IssueDetailsViewModel
    
    @Environment(\.openURL)
    private var openURL
    
    init(viewModel: IssueDetailsViewModel) {
        _model = State(initialValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let issue = model.issueDetails {
                    header(for: issue)
                    deck(for: issue)
                    volume()
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
        .animation(.smooth, value: model.issueDetails)
        .onAppear(perform: model.onAppear)
        .onReceive(model.linkActions) { linkHandlingInfo in
            openURL(
                linkHandlingInfo.url,
                prefersInApp: linkHandlingInfo.handleInApp
            )
        }
    }
    
    private func header(for issue: IssueDetails) -> some View {
        HStack(alignment: .top, spacing: 16) {
            RemoteImage(
                path: issue.smallUrl,
                backgroundColor: .clear
            )
            .frame(width: 150)
            .overlay {
                Layout.componentShape
                    .stroke(Color(.border))
            }
            
            VStack(alignment: .leading, spacing: 16) {
                headerTitle(issueTitle(for: issue))
                headerInfo(for: issue)
            }
        }
        .foregroundStyle(Color(.textSecondary))
    }
    
    @ViewBuilder
    private func deck(for issue: IssueDetails) -> some View {
        if let deck = issue.deck {
            Text(deck)
                .font(.body.weight(.semibold))
        }
    }
    
    @ViewBuilder
    private func volume() -> some View {
        if let volumeDetails = model.volumeDetails {
            VStack(alignment: .leading, spacing: 12) {
                Divider()
                Text(.IssueDetails.volumeLabel)
                    .font(.title3.bold())
                    .foregroundStyle(Color(.textPrimary))
                TableCard(cardData: .init(volumeDetails))
                Divider()
            }
        }
    }
    
    @ViewBuilder
    private func characters() -> some View {
        if !model.characterPreviews.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                Divider()
                
                Text(.IssueDetails.charactersSubtitle)
                    .font(.title3.bold())
                    .foregroundStyle(Color(.textPrimary))
                
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 50, maximum: .infinity)),
                    GridItem(.flexible(minimum: 50, maximum: .infinity)),
                    GridItem(.flexible(minimum: 50, maximum: .infinity))
                ], alignment: .center, spacing: 10) {
                    ForEach(model.characterPreviews) { characterPreview in
                        CharacterPreviewCard(character: characterPreview)
                    }
                }
                
                Divider()
            }
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
    
    private func headerTitle(_ title: String) -> some View {
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title.bold())
            .foregroundStyle(Color(.textPrimary))
    }
    
    private func headerInfo(for issue: IssueDetails) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if let name = issue.name {
                InfoItem(label: .IssueDetails.nameLabel, value: name)
            }
            if let volumeName = issue.volume.name {
                InfoItem(label: .IssueDetails.volumeLabel, value: volumeName)
            }
            InfoItem(label: .IssueDetails.issueLabel, value: issue.issueNumber)
            InfoItem(label: .IssueDetails.coverLabel, value: issue.coverDate)
            LinkText(
                destination: .init(safeString: issue.siteDetailUrl),
                resource: .Common.openOnWeb
            )
        }
        .font(.default)
    }
    
    private func issueTitle(for issue: IssueDetails) -> String {
        let volumeName = issue.volume.name ?? ""
        return "\(volumeName) #\(issue.issueNumber)"
    }
}

private struct CharacterPreviewCard: View {
    let character: IssueDetailsViewModel.CharacterPreview
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RemoteImage(path: character.imagePath, height: 80)
                .frame(width: 80)
                .clipShape(Layout.componentShape)
                .overlay {
                    Layout.componentShape
                        .stroke(Color(.border))
                }
            
            Text(character.name)
                .font(.headline)
                .foregroundStyle(Color(.textPrimary))
                .frame(width: 100, alignment: .leading)
                .lineLimit(2)
        }
    }
}

#Preview {
    IssueDetailsView(
        viewModel: HomeFlowCoordinator(
            container: .shared
        ).makeIssueDetailsViewModel(id: 163596)
    )
}
