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
    private var issues = [Issue]()
    private var movies = [Movie]()
    private let limit = 20
    private let characterRepository: CharacterRepository
    private let volumesRepository: VolumeRepository
    private let issuesRepository: IssueRepository
    private let moviesRepository: MovieRepository
    
    init(
        characterRepository: CharacterRepository,
        volumesRepository: VolumeRepository,
        issueRepository: IssueRepository,
        movieRepository: MovieRepository
    ) {
        self.characterRepository = characterRepository
        self.volumesRepository = volumesRepository
        self.issuesRepository = issueRepository
        self.moviesRepository = movieRepository
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
            isLastCard = card.itemId == issues.last?.id
        case .movie:
            isLastCard = card.itemId == movies.last?.id
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
                case .issue:
                    let result = try await issuesRepository.fetchIssues(limit: limit, offset: issues.count)
                    issues.append(contentsOf: result)
                    cardsData = issues.map { .init($0) }
                case .movie:
                    let result = try await moviesRepository.fetchMovies(limit: limit, offset: movies.count)
                    movies.append(contentsOf: result)
                    cardsData = movies.map { .init($0) }
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
                cardsData = []
                fetchData()
            } else {
                cardsData = characters.map { .init($0) }
            }
        case .volume:
            if volumes.isEmpty {
                cardsData = []
                fetchData()
            } else {
                cardsData = volumes.map { .init($0) }
            }
        case .issue:
            if issues.isEmpty {
                cardsData = []
                fetchData()
            } else {
                cardsData = issues.map { .init($0) }
            }
        case .movie:
            if movies.isEmpty {
                cardsData = []
                fetchData()
            } else {
                cardsData = movies.map { .init($0) }
            }
        }
    }
}
