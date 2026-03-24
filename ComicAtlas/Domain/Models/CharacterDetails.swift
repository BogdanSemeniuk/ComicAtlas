//
//  CharacterDetails.swift
//  ComicAtlas
//
//  Created by Codex on 24.03.2026.
//

import Foundation

struct CharacterDetails: Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String?
    let aliases: String?
    let birth: String?
    let characterEnemies: [String]
    let characterFriends: [String]
    let countOfIssueAppearances: Int
    let dateAdded: String
    let deck: String?
    let firstAppearedInIssueName: String?
    let firstAppearedInIssueNumber: String?
    let gender: Int
    let issueCredits: [String]
    let movies: [String]
    let originName: String?
    let powers: [String]
    let publisherName: String?
    let realName: String?
    let siteDetailUrl: String
    let teams: [String]
    let volumeCredits: [String]
    let iconUrl: String
    let smallUrl: String

    init(dto: CharacterDetailsDTO) {
        self.id = dto.id
        self.name = dto.name
        self.description = dto.description
        self.aliases = dto.aliases
        self.birth = dto.birth
        self.characterEnemies = dto.characterEnemies
        self.characterFriends = dto.characterFriends
        self.countOfIssueAppearances = dto.countOfIssueAppearances
        self.dateAdded = dto.dateAdded
        self.deck = dto.deck
        self.firstAppearedInIssueName = dto.firstAppearedInIssueName
        self.firstAppearedInIssueNumber = dto.firstAppearedInIssueNumber
        self.gender = dto.gender
        self.issueCredits = dto.issueCredits
        self.movies = dto.movies
        self.originName = dto.originName
        self.powers = dto.powers
        self.publisherName = dto.publisherName
        self.realName = dto.realName
        self.siteDetailUrl = dto.siteDetailUrl
        self.teams = dto.teams
        self.volumeCredits = dto.volumeCredits
        self.iconUrl = dto.iconUrl
        self.smallUrl = dto.smallUrl
    }
}
