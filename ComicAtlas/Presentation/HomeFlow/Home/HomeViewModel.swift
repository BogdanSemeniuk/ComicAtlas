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
    var pendingScrollTargetID: Int?
    var cardsData = [CardData]()
    private var characters = [Character]()
    private var volumes = [Volume]()
    private var issues = [Issue]()
    private var movies = [Movie]()
    private var rememberedScrollTargetIDs = [CollectionItem: Int]()
    private let limit = 20
    private let characterRepository: CharacterRepository
    private let volumesRepository: VolumeRepository
    private let issuesRepository: IssueRepository
    private let moviesRepository: MovieRepository
    private let navigationHandler: any NavigationHandler
    
    init(
        characterRepository: CharacterRepository,
        volumesRepository: VolumeRepository,
        issueRepository: IssueRepository,
        movieRepository: MovieRepository,
        navigationHandler: any NavigationHandler
    ) {
        self.characterRepository = characterRepository
        self.volumesRepository = volumesRepository
        self.issuesRepository = issueRepository
        self.moviesRepository = movieRepository
        self.navigationHandler = navigationHandler
    }
    
    func onFirstAppear() {
        fetchData()
    }
    
    func onAppear(card: CardData) {
        guard isLastCard(card) else { return }
        fetchData()
    }

    func visibleItemsDidChange(_ identifiers: [Int]) {
        guard let identifier = identifiers.first else { return }
        rememberedScrollTargetIDs[pickerSelection] = identifier
    }

    func didRestoreScrollPosition() {
        pendingScrollTargetID = nil
    }
    
    func selectCard(withData cardData: CardData) {
        switch cardData.type {
        case .character:
            navigationHandler.navigate(to: HomeFlowCoordinator.Route.character(id: cardData.itemId))
        case .volume:
            navigationHandler.navigate(to: HomeFlowCoordinator.Route.volume(id: cardData.itemId))
        case .issue:
            navigationHandler.navigate(to: HomeFlowCoordinator.Route.issue(id: cardData.itemId))
        case .movie:
            break
        }
    }
    
    private func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            defer { isLoading = false }
            do {
                try await fetchSelectedData()
            } catch {
                print(error)
            }
        }
    }
    
    private func pickerSelectionDidChange() {
        cardsData = cachedCardsData(for: pickerSelection)
        if cardsData.isEmpty {
            fetchData()
        } else {
            pendingScrollTargetID = rememberedScrollTargetIDs[pickerSelection]
        }
    }
    
    private func fetchSelectedData() async throws {
        switch SelectionState(pickerSelection) {
        case .character:
            let result = try await characterRepository.fetchCharacters(
                limit: limit,
                offset: characters.count
            )
            characters.append(contentsOf: result)
        case .volume:
            let result = try await volumesRepository.fetchVolumes(
                limit: limit,
                offset: volumes.count
            )
            volumes.append(contentsOf: result)
        case .issue:
            let result = try await issuesRepository.fetchIssues(
                limit: limit,
                offset: issues.count
            )
            issues.append(contentsOf: result)
        case .movie:
            let result = try await moviesRepository.fetchMovies(
                limit: limit,
                offset: movies.count
            )
            movies.append(contentsOf: result)
        }
        
        cardsData = cachedCardsData(for: pickerSelection)
    }
    
    private func cachedCardsData(for selection: CollectionItem) -> [CardData] {
        switch SelectionState(selection) {
        case .character:
            characters.map { .init($0) }
        case .volume:
            volumes.map { .init($0) }
        case .issue:
            issues.map { .init($0) }
        case .movie:
            movies.map { .init($0) }
        }
    }
    
    private func isLastCard(_ card: CardData) -> Bool {
        switch SelectionState(card.type) {
        case .character:
            card.itemId == characters.last?.id
        case .volume:
            card.itemId == volumes.last?.id
        case .issue:
            card.itemId == issues.last?.id
        case .movie:
            card.itemId == movies.last?.id
        }
    }
}

extension HomeViewModel {
    private enum SelectionState {
        case character
        case volume
        case issue
        case movie
        
        init(_ item: CollectionItem) {
            switch item {
            case .character:
                self = .character
            case .volume:
                self = .volume
            case .issue:
                self = .issue
            case .movie:
                self = .movie
            }
        }
    }
}
