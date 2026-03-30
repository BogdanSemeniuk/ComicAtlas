//
//  HeaderTitle.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 30.03.2026.
//

import SwiftUI

struct HeaderTitle: View {
    var text: String
    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title.bold())
            .foregroundStyle(Color(.textPrimary))
    }
}

#Preview {
    HeaderTitle(text: "")
}
