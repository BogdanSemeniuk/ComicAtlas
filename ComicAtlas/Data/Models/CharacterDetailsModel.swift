//
//  CharacterDetailsModel.swift
//  ComicAtlas
//
//  Created by Codex on 24.03.2026.
//

import Foundation

nonisolated
struct CharacterDetailsResponse: Decodable {
    let characterDetails: CharacterDetailsModel

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.characterDetails = try container.decode(CharacterDetailsModel.self, forKey: .results)
    }
}

struct CharacterDetailsModel: Codable, Sendable {
    let id: Int
    let name: String
    let description: String?
    let aliases: String?
    let birth: String?
    let characterEnemies: [ReferenceModel]
    let characterFriends: [ReferenceModel]
    let countOfIssueAppearances: Int
    let dateAdded: String
    let deck: String?
    let firstAppearedInIssue: IssueReferenceModel
    let gender: Int
    let image: ImageModel
    let issueCredits: [ReferenceModel]
    let movies: [ReferenceModel]
    let origin: ReferenceModel
    let powers: [ReferenceModel]
    let publisher: ReferenceModel
    let realName: String?
    let siteDetailUrl: String
    let teams: [ReferenceModel]
    let volumeCredits: [ReferenceModel]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case aliases
        case birth
        case characterEnemies = "character_enemies"
        case characterFriends = "character_friends"
        case countOfIssueAppearances = "count_of_issue_appearances"
        case dateAdded = "date_added"
        case deck
        case firstAppearedInIssue = "first_appeared_in_issue"
        case gender
        case image
        case issueCredits = "issue_credits"
        case movies
        case origin
        case powers
        case publisher
        case realName = "real_name"
        case siteDetailUrl = "site_detail_url"
        case teams
        case volumeCredits = "volume_credits"
    }
}
