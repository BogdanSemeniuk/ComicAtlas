//
//  SignInViewModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import Foundation

@Observable
class SignInViewModel {
    var email = "" {
        didSet { clearErrors() }
    }
    var password = "" {
        didSet { clearErrors() }
    }
    var emailError = ""
    var passwordError = ""
    var isLoading = false
    var isSignInDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
    var error: Error?
    private let inputValidator: InputValidating
    private let authRepository: AuthRepository
    private let navigationHandler: any NavigationHandler
    
    init(
        inputValidator: InputValidating,
        authRepository: AuthRepository,
        navigationHandler: any NavigationHandler
    ) {
        self.inputValidator = inputValidator
        self.authRepository = authRepository
        self.navigationHandler = navigationHandler
    }
    
    func signInAction() {
        isLoading = true
        Task {
            defer { isLoading = false }
            do {
                try inputValidator.validateEmail(email)
                try inputValidator.validatePassword(password)
                try await authRepository.signIn(email: email, password: password)
            } catch {
                guard let error = error as? ValidationError else {
                    self.error = error
                    return
                }
                if error == .invalidEmail {
                    emailError = error.localizedDescription
                } else {
                    passwordError = error.localizedDescription
                }
            }
        }
    }
    
    func signUpAction() {
        navigationHandler.navigate(to: AuthFlowCoordinator.Route.signUp)
    }
    
    private func clearErrors() {
        emailError = ""
        passwordError = ""
    }
}
