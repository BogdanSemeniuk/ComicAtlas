//
//  SignInViewModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import Combine
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
    let navigation: NavigationHandler
    
    init(
        inputValidator: InputValidating,
        authRepository: AuthRepository,
        navigation: NavigationHandler
    ) {
        self.inputValidator = inputValidator
        self.authRepository = authRepository
        self.navigation = navigation
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
        navigation.navigate(to: AuthFlowCoordinator.Route.signUp)
    }
    
    private func clearErrors() {
        emailError = ""
        passwordError = ""
    }
}
