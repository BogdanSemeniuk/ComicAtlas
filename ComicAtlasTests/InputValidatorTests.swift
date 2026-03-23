//
//  InputValidatorTests.swift
//  ComicAtlasTests
//
//  Created by Богдан Семенюк on 23.03.2026.
//

@testable import ComicAtlas
import Testing

@Suite("InputValidator tests")
struct InputValidatorTests {
    let sut = InputValidator()
    
    @Test
    func validEmail() {
        #expect(throws: Never.self) {
            try sut.validateEmail("abc@gmail.com")
        }
    }
    
    @Test
    func validEmailWithMinimumTopLevelDomainLength() {
        #expect(throws: Never.self) {
            try sut.validateEmail("abc@example.co")
        }
    }
    
    @Test
    func invalidEmail() {
        #expect(throws: ValidationError.invalidEmail) {
            try sut.validateEmail("abcgmail.com")
        }
    }
    
    @Test(arguments: [
        ("12345", ValidationError.passwordLength),
        ("abcdefgh", .passwordDigit),
        ("abcd1234", .passwordUppercaseLetter),
        ("Abcd 1234", .passwordSpace)
    ])
    func invalidPassword(
        password: String,
        expectedError: ValidationError
    ) {
        #expect(throws: expectedError) {
            try sut.validatePassword(password)
        }
    }
    
    @Test
    func validPassword() {
        #expect(throws: Never.self) {
            try sut.validatePassword("Abcd1234")
        }
    }
    
    @Test
    func validPasswordAtMinimumLengthBoundary() {
        #expect(throws: Never.self) {
            try sut.validatePassword("Abc12345")
        }
    }
}
