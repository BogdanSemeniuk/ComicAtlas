//
//  VolumeDetailsView.swift
//  ComicAtlas
//
//  Created by Codex on 30.03.2026.
//

import SwiftUI

struct VolumeDetailsView: View {
    @State private var model: VolumeDetailsViewModel

    @Environment(\.openURL)
    private var openURL

    init(viewModel: VolumeDetailsViewModel) {
        _model = State(initialValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let volume = model.volumeDetails {
                    header(for: volume)
                    deck(for: volume)
                    issues()
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
        .animation(.smooth, value: model.volumeDetails)
        .onAppear(perform: model.onAppear)
        .onReceive(model.linkActions) { linkHandlingInfo in
            openURL(
                linkHandlingInfo.url,
                prefersInApp: linkHandlingInfo.handleInApp
            )
        }
    }

    private func header(for volume: VolumeDetails) -> some View {
        HStack(alignment: .top, spacing: 16) {
            RemoteImage(
                path: volume.smallUrl,
                backgroundColor: .clear
            )
            .frame(width: 150)
            .overlay {
                Layout.componentShape
                    .stroke(Color(.border))
            }

            VStack(alignment: .leading, spacing: 16) {
                HeaderTitle(text: volume.name)
                headerInfo(for: volume)
            }
        }
        .foregroundStyle(Color(.textSecondary))
    }

    @ViewBuilder
    private func deck(for volume: VolumeDetails) -> some View {
        if let deck = volume.deck {
            Deck(text: deck)
        }
    }

    @ViewBuilder
    private func issues() -> some View {
        if !model.issuePreviews.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                Divider()

                Text(.VolumeDetails.issuesLabel)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color(.textPrimary))

                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(model.issuePreviews) { issuePreview in
                            RemoteImage(path: issuePreview.imagePath)
                                .frame(width: 150)
                                .onTapGesture {
                                    model.openIssueDetails(id: issuePreview.id)
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)

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

    private func headerInfo(for volume: VolumeDetails) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            InfoItem(label: .VolumeDetails.nameLabel, value: volume.name)
            InfoItem(label: .VolumeDetails.yearLabel, value: volume.startYear)
            InfoItem(label: .VolumeDetails.issuesLabel, value: volume.issuesCountDescription)
            if let publisherName = volume.publisher.name {
                InfoItem(label: .Common.publisherLabel, value: publisherName)
            }
            LinkText(
                destination: .init(safeString: volume.siteDetailUrl),
                resource: .Common.openOnWeb
            )
        }
        .font(.default)
    }
}

#Preview {
    VolumeDetailsView(
        viewModel: HomeFlowCoordinator(
            container: .shared
        ).makeVolumeDetailsViewModel(id: 22248)
    )
}
