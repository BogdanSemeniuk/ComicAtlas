//
//  AuthHandler.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 24.03.2026.
//

import FirebaseAuth
import Foundation

protocol AuthHandler {
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResult
    func signOut() throws
    func createUser(withEmail email: String, password: String) async throws -> AuthDataResult
    var currentUser: User? { get }
    func addStateDidChangeListener(_ listener: @escaping (Auth, User?) -> Void)
      -> NSObjectProtocol
    func removeStateDidChangeListener(_ handle: NSObjectProtocol)
}

extension Auth: AuthHandler {}
