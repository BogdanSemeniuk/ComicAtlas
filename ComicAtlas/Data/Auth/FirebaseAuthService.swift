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
    func registerUser(email: String, password: String, name: String) async throws -> FirebaseUserDTO
    func signOut() throws
    var isAuthenticatedPublisher: AnyPublisher<Bool, Never> { get }
}

final class FirebaseAuthService: AuthService {
    var isAuthenticatedPublisher: AnyPublisher<Bool, Never> {
        subject.eraseToAnyPublisher()
    }
    private let authProxy: FirebaseAuthAdapter
    private var stateHandler: NSObjectProtocol?
    private let subject: CurrentValueSubject<Bool, Never>
    
    init(authProxy: FirebaseAuthAdapter) {
        self.authProxy = authProxy
        self.subject = .init(authProxy.isAuthenticated)
        stateHandler = authProxy.isAuthenticatedListener { [weak self] isAuthenticated in
            self?.subject.send(isAuthenticated)
        }
    }
    
    deinit {
        guard let stateHandler else { return }
        authProxy.removeStateDidChangeListener(stateHandler)
    }
    
    func signIn(email: String, password: String) async throws {
        try await authProxy.signIn(withEmail: email, password: password)
    }
    
    func registerUser(email: String, password: String, name: String) async throws -> FirebaseUserDTO {
        try await authProxy.createUser(withEmail: email, password: password, name: name)
    }
    
    func signOut() throws {
        try authProxy.signOut()
    }
}
