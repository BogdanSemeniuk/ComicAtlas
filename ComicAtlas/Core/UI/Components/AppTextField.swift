//
//  AppTextField.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

struct AppTextField: View {
    @Binding var text: String
    var placeholder = ""
    var hasError = false
    var inputColor = Color(.textPrimary)
    var errorBorderColor = Color(.error)
    var keyboardType: UIKeyboardType = .default
    var autocorrectionDisabled = true
    
    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder).foregroundStyle(.textSecondary)
        )
        .textFieldStyle(
            AppTextFieldStyle(
                hasError: hasError,
                inputColor: inputColor,
                errorBorderColor: errorBorderColor,
                keyboardType: keyboardType,
                autocorrectionDisabled: autocorrectionDisabled
            )
        )
    }
}

#Preview {
    AppTextField(
        text: .constant(""),
        placeholder: String(localized: .Common.emailPlaceholder)
    )
}
