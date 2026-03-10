//
//  SignUpViewModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 09.03.2026.
//

import Foundation

@Observable
class SignUpViewModel {
    var fullName = "" {
        didSet { clearErrors() }
    }
    var email = "" {
        didSet { clearErrors() }
    }
    var password = "" {
        didSet { clearErrors() }
    }
    var confirmPassword = "" {
        didSet { clearErrors() }
    }
    var fullNameError = ""
    var emailError = ""
    var passwordError = ""
    var confirmPasswordError = ""
    var isLoading = false
    var isSignInDisabled: Bool {
        email.isEmpty || password.isEmpty || confirmPassword.isEmpty
    }
    var error: Error?
    private let inputValidator: InputValidating
    private let authRepository: AuthRepository
    private let navigationHandler: NavigationHandler
    
    init(
        inputValidator: InputValidating,
        authRepository: AuthRepository,
        navigationHandler: NavigationHandler
    ) {
        self.inputValidator = inputValidator
        self.authRepository = authRepository
        self.navigationHandler = navigationHandler
    }
    
    func createAccountAction() {
        isLoading = true
        Task {
            defer { isLoading = false }
            do {
                try inputValidator.validateEmail(email)
                try inputValidator.validatePassword(password)
                guard password == confirmPassword else { throw ValidationError.passwordsNotMatch }
                try await authRepository.registerUser(
                    email: email,
                    password: password,
                    name: fullName
                )
            } catch {
                guard let error = error as? ValidationError else {
                    self.error = error
                    return
                }
                switch error {
                case .invalidEmail:
                    emailError = error.localizedDescription
                case .passwordsNotMatch:
                    confirmPasswordError = error.localizedDescription
                default:
                    passwordError = error.localizedDescription
                }
            }
        }
    }
    
    func signInAction() {
        navigationHandler.pop()
    }
    
    private func clearErrors() {
        emailError = ""
        passwordError = ""
        confirmPasswordError = ""
    }
}
