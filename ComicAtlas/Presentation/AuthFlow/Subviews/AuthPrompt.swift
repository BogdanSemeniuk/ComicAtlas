//
//  AuthPrompt.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 09.03.2026.
//

import SwiftUI

struct AuthPrompt: View {
    var description: LocalizedStringResource
    var actionLabel: LocalizedStringResource
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Text(description)
                .fontWeight(.medium)
            Button {
                action()
            } label: {
                Text(actionLabel)
                    .fontWeight(.bold)
                    .foregroundStyle(.brandPrimary)
                    .padding(6)
            }
        }
        .font(.title3)
    }
}

#Preview {
    AuthPrompt(description: .SignIn.signUpPrompt, actionLabel: .SignIn.signUpButton, action: {})
}
