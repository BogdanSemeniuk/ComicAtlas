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
    }
    
    private var inputs: some View {
        VStack(spacing: 4) {
            InputSection(
                label: .Common.emailLabel,
                text: $model.email,
                placeholder: .Common.emailPlaceholder,
                inputError: .value(""))
            InputSection(
                label: .Common.passwordLabel,
                text: $model.password,
                placeholder: .Common.passwordPlaceholder,
                isSecure: true,
                inputError: .value("")
            )
            ActionButton(
                title: .SignIn.signInButton,
                action: {
                    print("Sign in")
                }
            )
        }
        .padding(Layout.horizontalPadding)
        .background(.white, in: Layout.componentShape)
        .compositingGroup()
        .shadow(color: .black.opacity(0.1), radius: 10)
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

#Preview {
    SignInView(model: .init())
}
