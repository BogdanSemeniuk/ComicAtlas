//
//  AuthHeader.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

struct AuthHeader: View {
    var title: LocalizedStringResource
    var description: LocalizedStringResource
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(description)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color(.textSecondary))
        }
    }
}

#Preview {
    AuthHeader(title: .SignIn.title, description: .SignIn.description)
}
