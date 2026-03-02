//
//  AppTextFieldStyle.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

struct AppTextFieldStyle: TextFieldStyle {
    var hasError: Bool
    var inputColor: Color
    var errorBorderColor: Color
    var keyboardType: UIKeyboardType
    var autocorrectionDisabled: Bool
    var trailingInputInset: CGFloat = 0
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(autocorrectionDisabled)
            .keyboardType(keyboardType)
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .padding(.trailing, trailingInputInset)
            .overlay {
                Layout.componentShape
                    .stroke(borderStrokeColor)
            }
            .background(.textFieldBackground, in: Layout.componentShape)
            .foregroundStyle(inputColor)
    }
    
    private var borderStrokeColor: Color {
        hasError ? errorBorderColor : .clear
    }
}
