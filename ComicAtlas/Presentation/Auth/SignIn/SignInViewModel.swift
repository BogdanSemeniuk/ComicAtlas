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
    private let inputValidator: InputValidating
    
    init(inputValidator: InputValidating) {
        self.inputValidator = inputValidator
    }
    
    func signInAction() {
        do {
            try inputValidator.validateEmail(email)
            try inputValidator.validatePassword(password)
            // Sign in request
        } catch {
            if let error = error as? ValidationError {
                if error == .invalidEmail {
                    emailError = error.localizedDescription
                } else {
                    passwordError = error.localizedDescription
                }
            } else {
                // Another error
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
