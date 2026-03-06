//
//  AuthRepository.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 06.03.2026.
//

import Foundation

protocol AuthRepository {
    func signIn(email: String, password: String) async throws
    func registerUser(email: String, password: String, name: String) async throws -> UserInfo
    func signOut() throws
}
