//
//  SignUpView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 09.03.2026.
//

import SwiftUI

struct SignUpView: View {
    @State private var model: SignUpViewModel
    
    init(coordinator: AuthFlowCoordinator) {
        _model = State(initialValue: coordinator.makeSignUpViewModel())
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(.logo)
                    .resizable()
                    .frame(width: Layout.logoSize, height: Layout.logoSize)
                AuthHeader(title: .SignUp.title, description: .SignUp.description)
                inputs
                    .padding(.vertical, 24)
                AuthPrompt(
                    description: .SignUp.signInPrompt,
                    actionLabel: .SignUp.signInButton,
                    action: model.signInAction
                )
            }
            .padding(.horizontal, Layout.horizontalPadding)
            .errorAlert(error: $model.error)
        }
        .background(Color(.background))
    }
    
    private var inputs: some View {
        VStack(spacing: 4) {
            InputSection(
                label: .Common.nameLabel,
                text: $model.fullName,
                placeholder: .Common.namePlaceholder,
                inputError: model.fullNameError
            )
            InputSection(
                label: .Common.emailLabel,
                text: $model.email,
                placeholder: .Common.emailPlaceholder,
                inputError: model.emailError
            )
            InputSection(
                label: .Common.passwordLabel,
                text: $model.password,
                placeholder: .Common.passwordPlaceholder,
                isSecure: true,
                inputError: model.passwordError
            )
            InputSection(
                label: .Common.confirmPasswordLabel,
                text: $model.confirmPassword,
                placeholder: .Common.passwordPlaceholder,
                isSecure: true,
                inputError: model.confirmPasswordError
            )
            ActionButton(
                title: .SignUp.createButton,
                disabled: model.isSignInDisabled,
                isLoading: model.isLoading,
                action: model.createAccountAction
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
