//
//  AuthServiceMock.swift
//  ComicAtlasTests
//
//  Created by Богдан Семенюк on 21.04.2026.
//

import Combine
import Foundation
@testable import ComicAtlas

class AuthServiceMock: AuthService {
    var isAuthenticatedPublisher: AnyPublisher<Bool, Never> {
        authPublisher.eraseToAnyPublisher()
    }
    var isAuthenticated: Bool { isLoggedIn }
    private(set) var signInCallCount = 0
    private(set) var registerCallCount = 0
    private(set) var signOutCallCount = 0
    private(set) var receivedEmail: String?
    private(set) var receivedPassword: String?
    private(set) var registeredUserId = "1"
    private var authPublisher = PassthroughSubject<Bool, Never>()
    private var shouldThrowError: Bool
    private var isLoggedIn: Bool
    
    init(isLoggedIn: Bool, shouldThrowError: Bool) {
        self.isLoggedIn = isLoggedIn
        self.shouldThrowError = shouldThrowError
    }
    
    func signIn(email: String, password: String) async throws {
        signInCallCount += 1
        guard !shouldThrowError else { throw TestError.expectedFailure }
        receivedEmail = email
        receivedPassword = password
        isLoggedIn = true
        authPublisher.send(true)
    }
    
    func registerUser(email: String, password: String, name: String) async throws -> ComicAtlas.FirebaseUserDTO {
        registerCallCount += 1
        guard !shouldThrowError else { throw TestError.expectedFailure }
        receivedEmail = email
        receivedPassword = password
        isLoggedIn = true
        authPublisher.send(true)
        return .init(uid: registeredUserId, email: email, displayName: name)
        
    }
    
    func signOut() throws {
        signOutCallCount += 1
        guard !shouldThrowError else { throw TestError.expectedFailure }
        isLoggedIn = false
        authPublisher.send(false)
    }
}
