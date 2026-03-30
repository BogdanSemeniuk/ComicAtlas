//
//  CardTitle.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 30.03.2026.
//

import SwiftUI

struct CardTitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title2.weight(.semibold))
            .lineLimit(2)
            .minimumScaleFactor(0.5)
            .foregroundStyle(.textPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CardTitle(text: "Title")
}
