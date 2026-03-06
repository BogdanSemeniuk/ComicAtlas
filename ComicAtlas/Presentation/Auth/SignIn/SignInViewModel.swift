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
    
    init(
        inputValidator: InputValidating,
        authRepository: AuthRepository
    ) {
        self.inputValidator = inputValidator
        self.authRepository = authRepository
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
        
    }
    
    private func clearErrors() {
        emailError = ""
        passwordError = ""
    }
}
