//
//  ValidationError.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 12.02.2026.
//

import Foundation

enum ValidationError: LocalizedError {
    case invalidEmail
    case passwordLength
    case passwordDigit
    case passwordSpace
    case passwordUppercaseLetter
    case passwordsNotMatch
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail: .init(localized: .ValidationError.invalidEmail)
        case .passwordLength: .init(localized: .ValidationError.passwordLength)
        case .passwordDigit: .init(localized: .ValidationError.passwordDigit)
        case .passwordUppercaseLetter: .init(localized: .ValidationError.passwordUppercaseLetter)
        case .passwordSpace: .init(localized: .ValidationError.passwordSpace)
        case .passwordsNotMatch: .init(localized: .ValidationError.passwordsNotMatch)
        }
    }
}
