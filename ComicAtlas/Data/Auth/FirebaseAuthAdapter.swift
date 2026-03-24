//
//  FirebaseAuthAdapter.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 24.03.2026.
//

import FirebaseAuth
import Foundation

protocol FirebaseAuthAdapter {
    func signIn(withEmail email: String, password: String) async throws
    func signOut() throws
    func createUser(withEmail email: String, password: String, name: String) async throws -> FirebaseUserDTO
    func removeStateDidChangeListener(_ handle: NSObjectProtocol)
    func isAuthenticatedListener(_ listener: @escaping (Bool) -> Void)
      -> NSObjectProtocol
    var isAuthenticated: Bool { get }
}

final class FirebaseAuthAdapterImpl: FirebaseAuthAdapter {
    var isAuthenticated: Bool {
        authHandler.currentUser != nil
    }
    private let authHandler: AuthHandler
    
    init(authHandler: AuthHandler) {
        self.authHandler = authHandler
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        _ = try await authHandler.signIn(withEmail: email, password: password)
    }
    
    func createUser(withEmail email: String, password: String, name: String) async throws -> FirebaseUserDTO {
        let result = try await authHandler.createUser(withEmail: email, password: password)
        let changeRequest = result.user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()
        return FirebaseUserDTO(result.user)
    }
    
    func signOut() throws {
        try authHandler.signOut()
    }
    
    func removeStateDidChangeListener(_ handle: NSObjectProtocol) {
        authHandler.removeStateDidChangeListener(handle)
    }
    
    func isAuthenticatedListener(_ listener: @escaping (Bool) -> Void)
    -> NSObjectProtocol {
        authHandler.addStateDidChangeListener { auth, _ in
            listener(auth.currentUser != nil)
        }
    }
}
