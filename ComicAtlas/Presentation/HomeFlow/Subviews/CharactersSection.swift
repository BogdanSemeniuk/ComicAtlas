//
//  CharactersSection.swift
//  ComicAtlas
//
//  Created by Codex on 31.03.2026.
//

import SwiftUI

struct CharactersSection: View {
    let title: LocalizedStringResource
    let previews: [ItemPreview]
    var onTap: (ItemPreview) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Divider()

            Text(title)
                .font(.title3.bold())
                .foregroundStyle(Color(.textPrimary))

            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 50, maximum: .infinity)),
                GridItem(.flexible(minimum: 50, maximum: .infinity)),
                GridItem(.flexible(minimum: 50, maximum: .infinity))
            ], alignment: .center, spacing: 10) {
                ForEach(previews) { characterPreview in
                    CharacterPreviewCard(character: characterPreview, onTap: onTap)
                }
            }

            Divider()
        }
    }
}
