//
//  RootView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 06.03.2026.
//

import FirebaseAuth
import SwiftUI

struct RootView: View {
    @State private var signInViewModel = SignInViewModel(
        inputValidator: InputValidator(),
        authRepository: AuthRepositoryImpl(
            authService: FirebaseAuthService(authHandler: Auth.auth())
        )
    )

    var body: some View {
        SignInView(model: signInViewModel)
    }
}

#Preview {
    RootView()
}
