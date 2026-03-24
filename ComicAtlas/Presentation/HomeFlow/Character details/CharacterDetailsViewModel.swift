//
//  CharacterDetailsViewModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 24.03.2026.
//

import Foundation

@Observable
class CharacterDetailsViewModel {
    private let id: Int
    private let navigationHandler: any NavigationHandler
    
    init(
        id: Int,
        navigationHandler: any NavigationHandler
    ) {
        self.id = id
        self.navigationHandler = navigationHandler
    }
}
