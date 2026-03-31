//
//  CharacterPreviewCard.swift
//  ComicAtlas
//
//  Created by Codex on 31.03.2026.
//

import SwiftUI

struct CharacterPreviewCard: View {
    let character: ItemPreview
    var onTap: (ItemPreview) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RemoteImage(path: character.imagePath, height: 80)
                .frame(width: 80)
                .clipShape(Layout.componentShape)
                .overlay {
                    Layout.componentShape
                        .stroke(Color(.border))
                }

            Text(character.title)
                .font(.headline)
                .foregroundStyle(Color(.textPrimary))
                .frame(width: 100, alignment: .leading)
                .lineLimit(2)
        }
        .contentShape(.rect)
        .onTapGesture { onTap(character) }
    }
}
