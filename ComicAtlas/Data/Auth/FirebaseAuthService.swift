//
//  FirebaseAuthService.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 06.03.2026.
//

import Combine
import FirebaseAuth

protocol AuthService {
    func signIn(email: String, password: String) async throws
    func registerUser(email: String, password: String, name: String) async throws -> User
    func signOut() throws
    var isAuthenticatedPublisher: AnyPublisher<Bool, Never> { get }
}

protocol AuthHandler {
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResult
    func signOut() throws
    func createUser(withEmail email: String, password: String) async throws -> AuthDataResult
    var currentUser: User? { get }
    func addStateDidChangeListener(_ listener: @escaping (Auth, User?) -> Void)
      -> NSObjectProtocol
    func removeStateDidChangeListener(_ handle: NSObjectProtocol)
}

final class FirebaseAuthService: AuthService {
    var isAuthenticatedPublisher: AnyPublisher<Bool, Never> {
        subject.eraseToAnyPublisher()
    }
    private let authHandler: AuthHandler
    private var stateHandler: NSObjectProtocol?
    private let subject: CurrentValueSubject<Bool, Never>
    
    init(authHandler: AuthHandler) {
        self.authHandler = authHandler
        self.subject = .init(authHandler.currentUser != nil)
        stateHandler = authHandler.addStateDidChangeListener { [weak self] auth, _ in
            self?.subject.send(auth.currentUser != nil)
        }
    }
    
    deinit {
        guard let stateHandler else { return }
        authHandler.removeStateDidChangeListener(stateHandler)
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

extension Auth: AuthHandler {}
