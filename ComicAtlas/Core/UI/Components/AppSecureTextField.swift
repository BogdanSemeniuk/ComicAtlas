//
//  AppSecureTextField.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

struct AppSecureTextField: View {
    @Binding var text: String
    var placeholder = ""
    var isFocused = false
    var hasError = false
    var eyeColor = Color(.textPrimary)
    var inputColor = Color(.textPrimary)
    var errorBorderColor = Color(.error)
    var trailingInputInset: CGFloat = 44
    var keyboardType: UIKeyboardType = .default
    var autocorrectionDisabled = true
    @State private var isVisible = false
    
    var body: some View {
        ZStack {
            TextField(
                "",
                text: $text,
                prompt: Text(placeholder).foregroundStyle(.textSecondary)
            )
            .opacity(isVisible ? 1 : 0)
            SecureField(
                "",
                text: $text,
                prompt: Text(placeholder).foregroundStyle(.textSecondary)
            )
            .opacity(isVisible ? 0 : 1)
        }
        .textFieldStyle(
            AppTextFieldStyle(
                hasError: hasError,
                inputColor: inputColor,
                errorBorderColor: errorBorderColor,
                keyboardType: keyboardType,
                autocorrectionDisabled: autocorrectionDisabled,
                trailingInputInset: trailingInputInset
            )
        )
        .textContentType(.password)
        .overlay(alignment: .trailing) {
            Button {
                isVisible.toggle()
            } label: {
                Image(si: isVisible ? .eyeSlash : .eye)
                    .foregroundStyle(eyeColor)
                    .padding()
            }
            .animation(.smooth, value: isVisible)
        }
    }
}

#Preview {
    AppSecureTextField(
        text: .constant(""),
        placeholder: String(localized: .Common.passwordPlaceholder)
    )
}
