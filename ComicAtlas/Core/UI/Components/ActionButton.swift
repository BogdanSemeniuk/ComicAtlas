//
//  ActionButton.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

struct ActionButton: View {
    var title: LocalizedStringResource
    var disabled = false
    var isLoading = false
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            if isLoading {
                ProgressView()
                    .controlSize(.regular)
                    .tint(.white)
            } else {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(height: 52)
                    .frame(maxWidth: .infinity)
                    .background(
                        .brandPrimary,
                        in: Layout.componentShape
                    )
            }
        }
        .disabled(disabled || isLoading)
        .opacity(disabled ? 0.7 : 1)
        .appShadow()
    }
}

#Preview {
    ActionButton(
        title: .SignIn.signInButton,
        disabled: false,
        isLoading: true,
        action: {}
    )
}
