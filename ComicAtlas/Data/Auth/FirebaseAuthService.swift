//
//  FirebaseAuthService.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 06.03.2026.
//

import FirebaseAuth

protocol AuthService {
    func signIn(email: String, password: String) async throws
    func registerUser(email: String, password: String, name: String) async throws -> User
    func signOut() throws
}

protocol AuthHandler {
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResult
    func signOut() throws
    func createUser(withEmail email: String, password: String) async throws -> AuthDataResult
    var currentUser: User? { get }
    var isAuthenticated: Bool { get }
}

struct FirebaseAuthService: AuthService {
    private let authHandler: AuthHandler
    
    init(authHandler: AuthHandler) {
        self.authHandler = authHandler
    }
    
    func signIn(email: String, password: String) async throws {
        _ = try await authHandler.signIn(withEmail: email, password: password)
    }
    
    func registerUser(email: String, password: String, name: String) async throws -> User {
        let result = try await authHandler.createUser(withEmail: email, password: password)
        let changeRequest = result.user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()
        return result.user
    }
    
    func signOut() throws {
        try authHandler.signOut()
    }
}

extension Auth: AuthHandler {
    var isAuthenticated: Bool {
        currentUser != nil
    }
}
