//
//  HomeViewModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import Foundation

@Observable
class HomeViewModel {
    var isLoading = false
    var pickerSelection: CollectionItem = .character {
        didSet {
            pickerSelectionDidChange()
        }
    }
    var cardsData = [CardData]()
    private var characters = [Character]()
    private var volumes = [Volume]()
    private let limit = 20
    private let characterRepository: CharacterRepository
    private let volumesRepository: VolumeRepository
    
    init(
        characterRepository: CharacterRepository,
        volumesRepository: VolumeRepository
    ) {
        self.characterRepository = characterRepository
        self.volumesRepository = volumesRepository
    }
    
    func onAppear() {
        fetchData()
    }
    
    func onAppear(card: CardData) {
        var isLastCard = false
        switch card.type {
        case .character:
            isLastCard = card.itemId == characters.last?.id
        case .volume:
            isLastCard = card.itemId == volumes.last?.id
        case .issue:
            break
        case .movie:
            break
        }
        guard isLastCard else { return }
        fetchData()
    }
    
    private func fetchData() {
        isLoading = true
        Task {
            do {
                switch pickerSelection {
                case .character:
                    let result = try await characterRepository.fetchCharacters(limit: limit, offset: characters.count)
                    characters.append(contentsOf: result)
                    cardsData = characters.map { .init($0) }
                case .volume:
                    let result = try await volumesRepository.fetchVolumes(limit: limit, offset: volumes.count)
                    volumes.append(contentsOf: result)
                    cardsData = volumes.map { .init($0) }
                default: break
                }
            } catch {
                print(error)
            }
            isLoading = false
        }
    }
    
    private func pickerSelectionDidChange() {
        switch pickerSelection {
        case .character:
            if characters.isEmpty {
                fetchData()
            } else {
                cardsData = characters.map { .init($0) }
            }
        case .volume:
            if volumes.isEmpty {
                fetchData()
            } else {
                cardsData = volumes.map { .init($0) }
            }
        case .issue: cardsData = []
        case .movie: cardsData = []
        }
    }
}
