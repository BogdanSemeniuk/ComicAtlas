//
//  InputSection.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

struct InputSection: View {
    var label: LocalizedStringResource?
    @Binding var text: String
    var placeholder: LocalizedStringResource?
    var isSecure = false
    var inputError = ""
    
    var body: some View {
        VStack(spacing: 0) {
            if let label {
                TextFieldLabel(resource: label)
                    .padding(.bottom, 12)
            }
            if isSecure {
                AppSecureTextField(
                    text: $text,
                    placeholder: placeholderText
                )
            } else {
                AppTextField(
                    text: $text,
                    placeholder: placeholderText
                )
            }
            ErrorMessage(message: inputError)
        }
    }
    
    private var placeholderText: String {
        guard let placeholder else { return "" }
        return .init(localized: placeholder)
    }
}

#Preview {
    VStack {
        InputSection(
            label: .Common.emailLabel,
            text: .constant(""),
            placeholder: .Common.emailPlaceholder
        )
        InputSection(
            label: .Common.passwordLabel,
            text: .constant(""),
            placeholder: .Common.passwordPlaceholder,
            isSecure: true
        )
        InputSection(
            label: .Common.emailLabel,
            text: .constant(""),
            placeholder: .Common.emailPlaceholder,
            inputError: "Email is invalid"
        )
    }
}
