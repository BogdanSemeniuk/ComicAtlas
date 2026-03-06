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
            AuthHeader(title: .SignIn.title, description: .SignIn.description)
            Spacer()
            inputs
            Spacer()
            signUpPrompt
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
    
    private var signUpPrompt: some View {
        HStack(spacing: 0) {
            Text(.SignIn.signUpPrompt)
                .fontWeight(.medium)
            Button {
                model.signUpAction()
            } label: {
                Text(.SignIn.signUpButton)
                    .fontWeight(.bold)
                    .foregroundStyle(.brandPrimary)
                    .padding(6)
            }
        }
        .font(.title3)
    }
}
