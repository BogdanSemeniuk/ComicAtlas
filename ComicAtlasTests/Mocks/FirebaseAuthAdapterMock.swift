//
//  FirebaseAuthAdapterMock.swift
//  ComicAtlasTests
//
//  Created by Богдан Семенюк on 24.03.2026.
//

import Foundation
@testable import ComicAtlas

final class FirebaseAuthAdapterMock: FirebaseAuthAdapter {
    var isAuthenticated: Bool { isLoggedIn }
    private var shouldThrowError: Bool
    private var isLoggedIn: Bool
    private(set) var signInCallCount = 0
    private(set) var signOutCallCount = 0
    private(set) var createUserCallCount = 0
    private(set) var removeStateDidChangeListenerCallCount = 0
    private(set) var isAuthenticatedListenerCallCount = 0
    private(set) var receivedSignInEmail: String?
    private(set) var receivedSignInPassword: String?
    private(set) var receivedCreateUserEmail: String?
    private(set) var receivedCreateUserPassword: String?
    private(set) var receivedCreateUserName: String?
    private(set) var removedHandle: NSObjectProtocol?
    private let stateDidChangeHandle = NSObject()
    private var authStateListener: ((Bool) -> Void)?
    
    init(isLoggedIn: Bool, shouldThrowError: Bool) {
        self.isLoggedIn = isLoggedIn
        self.shouldThrowError = shouldThrowError
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        signInCallCount += 1
        receivedSignInEmail = email
        receivedSignInPassword = password
        guard !shouldThrowError else { throw TestError.expectedFailure }
        isLoggedIn = true
    }
    
    func signOut() throws {
        signOutCallCount += 1
        guard !shouldThrowError else { throw TestError.expectedFailure }
        isLoggedIn = false
    }
    
    func createUser(withEmail email: String, password: String, name: String) async throws -> ComicAtlas.FirebaseUserDTO {
        createUserCallCount += 1
        receivedCreateUserEmail = email
        receivedCreateUserPassword = password
        receivedCreateUserName = name
        guard !shouldThrowError else { throw TestError.expectedFailure }
        return FirebaseUserDTO(uid: UUID().uuidString, email: email, displayName: name)
    }
    
    func removeStateDidChangeListener(_ handle: any NSObjectProtocol) {
        removeStateDidChangeListenerCallCount += 1
        removedHandle = handle
    }
    
    func isAuthenticatedListener(_ listener: @escaping (Bool) -> Void) -> any NSObjectProtocol {
        isAuthenticatedListenerCallCount += 1
        authStateListener = listener
        return stateDidChangeHandle
    }
    
    func sendAuthenticationState(_ isAuthenticated: Bool) {
        isLoggedIn = isAuthenticated
        authStateListener?(isAuthenticated)
    }
}
