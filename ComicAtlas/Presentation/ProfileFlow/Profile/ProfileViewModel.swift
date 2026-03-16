//
//  ProfileViewModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import Foundation

@Observable
class ProfileViewModel {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func logoutAction() {
        try? authRepository.signOut()
    }
}
