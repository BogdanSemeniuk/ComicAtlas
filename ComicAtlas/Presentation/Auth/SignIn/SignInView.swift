//
//  SignInView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

struct SignInView: View {
    @Bindable var model: SignInViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Image(.logo)
                .resizable()
                .frame(width: Layout.logoSize, height: Layout.logoSize)
            AuthHeader(title: .SignIn.title, description: .SignIn.description)
            Spacer()
            inputs
            Spacer()
            AuthPrompt(
                description: .SignIn.signUpPrompt,
                actionLabel: .SignIn.signUpButton,
                action: model.signUpAction
            )
        }
        .padding(.horizontal, Layout.horizontalPadding)
        .background(Color(.background))
        .errorAlert(error: $model.error)
    }
    
    private var inputs: some View {
        VStack(spacing: 4) {
            InputSection(
                label: .Common.emailLabel,
                text: $model.email,
                placeholder: .Common.emailPlaceholder,
                inputError: model.emailError)
            InputSection(
                label: .Common.passwordLabel,
                text: $model.password,
                placeholder: .Common.passwordPlaceholder,
                isSecure: true,
                inputError: model.passwordError
            )
            ActionButton(
                title: .SignIn.signInButton,
                disabled: model.isSignInDisabled,
                isLoading: model.isLoading,
                action: model.signInAction
            )
        }
        .padding(Layout.horizontalPadding)
        .background(.white, in: Layout.componentShape)
        .compositingGroup()
        .appShadow()
        .overlay {
            Layout.componentShape
                .stroke(Color(.border))
        }
    }
}
