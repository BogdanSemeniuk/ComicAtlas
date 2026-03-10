//
//  RootViewModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import Combine
import Foundation

@Observable
class RootViewModel {
    var isAuthenticated: Bool?
    private let authRepository: AuthRepository
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        authRepository: AuthRepository
    ) {
        self.authRepository = authRepository
        self.setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        authRepository
            .isAuthenticatedPublisher
            .removeDuplicates()
            .sink { [weak self] in
                self?.isAuthenticated = $0
            }
            .store(in: &cancellables)
    }
}
