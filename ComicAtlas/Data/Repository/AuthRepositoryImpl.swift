//
//  AuthRepositoryImpl.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 06.03.2026.
//

import Combine
import Foundation

struct AuthRepositoryImpl: AuthRepository {
    var authService: AuthService
    var isAuthenticatedPublisher: AnyPublisher<Bool, Never> {
        authService.isAuthenticatedPublisher
    }
    
    func signIn(email: String, password: String) async throws {
        try await authService.signIn(email: email, password: password)
    }
    
    func registerUser(email: String, password: String, name: String) async throws -> UserInfo {
        let user = try await authService.registerUser(email: email, password: password, name: name)
        return .init(dto: FirebaseUserDTO(user))
    }
    
    func signOut() throws {
        try authService.signOut()
    }
}
