//
//  Deck.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 30.03.2026.
//

import SwiftUI

struct Deck: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.body.weight(.semibold))
            .foregroundStyle(Color(.textPrimary))
    }
}

#Preview {
    Deck(text: "")
}
