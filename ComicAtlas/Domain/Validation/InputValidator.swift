//
//  InputValidator.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 12.02.2026.
//

import Foundation

protocol InputValidating {
    func validateEmail(_ email: String) throws
    func validatePassword(_ password: String) throws
}

struct InputValidator: InputValidating {
    func validateEmail(_ email: String) throws {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: email) {
            throw ValidationError.invalidEmail
        }
    }
    
    func validatePassword(_ password: String) throws {
        guard password.count >= 8 else { throw ValidationError.passwordLength }
        guard password.rangeOfCharacter(from: .decimalDigits) != nil else { throw ValidationError.passwordDigit }
        guard password.rangeOfCharacter(from: .uppercaseLetters) != nil else {
            throw ValidationError.passwordUppercaseLetter
        }
        guard password.rangeOfCharacter(from: .whitespaces) == nil else { throw ValidationError.passwordSpace }
    }
}
