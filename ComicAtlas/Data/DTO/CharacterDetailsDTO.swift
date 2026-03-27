//
//  CharacterDetailsDTO.swift
//  ComicAtlas
//
//  Created by Codex on 24.03.2026.
//

import Foundation

struct CharacterDetailsDTO {
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
    let issueCredits: [ReferenceDTO]
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

    init(_ details: CharacterDetailsModel) {
        self.id = details.id
        self.name = details.name
        self.description = details.description
        self.aliases = details.aliases
        self.birth = details.birth
        self.characterEnemies = details.characterEnemies.compactMap(\.name)
        self.characterFriends = details.characterFriends.compactMap(\.name)
        self.countOfIssueAppearances = details.countOfIssueAppearances
        self.dateAdded = details.dateAdded
        self.deck = details.deck
        self.firstAppearedInIssueName = details.firstAppearedInIssue.name
        self.firstAppearedInIssueNumber = details.firstAppearedInIssue.issueNumber
        self.gender = details.gender
        self.issueCredits = details.issueCredits.map { .init($0) }
        self.movies = details.movies.compactMap(\.name)
        self.originName = details.origin.name
        self.powers = details.powers.compactMap(\.name)
        self.publisherName = details.publisher.name
        self.realName = details.realName
        self.siteDetailUrl = details.siteDetailUrl
        self.teams = details.teams.compactMap(\.name)
        self.volumeCredits = details.volumeCredits.compactMap(\.name)
        self.iconUrl = details.image.iconUrl
        self.smallUrl = details.image.smallUrl
    }
}
