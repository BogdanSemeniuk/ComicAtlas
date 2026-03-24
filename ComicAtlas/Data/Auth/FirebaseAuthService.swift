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
    private let firebaseAdapter: FirebaseAuthAdapter
    private var stateHandler: NSObjectProtocol?
    private let subject: CurrentValueSubject<Bool, Never>
    
    init(firebaseAdapter: FirebaseAuthAdapter) {
        self.firebaseAdapter = firebaseAdapter
        self.subject = .init(firebaseAdapter.isAuthenticated)
        stateHandler = firebaseAdapter.isAuthenticatedListener { [weak self] isAuthenticated in
            self?.subject.send(isAuthenticated)
        }
    }
    
    deinit {
        guard let stateHandler else { return }
        firebaseAdapter.removeStateDidChangeListener(stateHandler)
    }
    
    func signIn(email: String, password: String) async throws {
        try await firebaseAdapter.signIn(withEmail: email, password: password)
    }
    
    func registerUser(email: String, password: String, name: String) async throws -> FirebaseUserDTO {
        try await firebaseAdapter.createUser(withEmail: email, password: password, name: name)
    }
    
    func signOut() throws {
        try firebaseAdapter.signOut()
    }
}
