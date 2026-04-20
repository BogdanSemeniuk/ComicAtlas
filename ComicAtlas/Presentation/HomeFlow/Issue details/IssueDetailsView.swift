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
                HeaderTitle(text: issue.title)
                headerInfo(for: issue)
            }
        }
        .foregroundStyle(Color(.textSecondary))
    }
    
    @ViewBuilder
    private func deck(for issue: IssueDetails) -> some View {
        if let deck = issue.deck {
            Deck(text: deck)
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
                    .onTapGesture {
                        model.openVolume(id: volumeDetails.id)
                    }
                Divider()
            }
        }
    }
    
    @ViewBuilder
    private func characters() -> some View {
        if !model.characterPreviews.isEmpty {
            CharactersSection(
                title: .IssueDetails.charactersSubtitle,
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
    
    private func headerInfo(for issue: IssueDetails) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if let name = issue.name {
                InfoItem(label: .IssueDetails.nameLabel, value: name)
            }
            if let volumeName = issue.volume.name {
                InfoItem(label: .IssueDetails.volumeLabel, value: volumeName)
            }
            InfoItem(label: .IssueDetails.issueLabel, value: issue.issueNumber)
            if let coverDate = issue.coverDate {
                InfoItem(label: .IssueDetails.coverLabel, value: coverDate)
            }
            LinkText(
                destination: .init(safeString: issue.siteDetailUrl),
                resource: .Common.openOnWeb
            )
        }
        .font(.default)
    }
}

#Preview {
    IssueDetailsView(
        viewModel: HomeFlowCoordinator(
            container: .shared
        ).makeIssueDetailsViewModel(id: 163596)
    )
}
