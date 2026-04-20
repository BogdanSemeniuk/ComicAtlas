//
//  IssueDetailsModel.swift
//  ComicAtlas
//
//  Created by Codex on 27.03.2026.
//

import Foundation

nonisolated
struct IssueDetailsResponse: Decodable {
    let issueDetails: IssueDetailsModel

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.issueDetails = try container.decode(IssueDetailsModel.self, forKey: .results)
    }
}

struct IssueDetailsModel: Codable, Sendable {
    let id: Int
    let name: String?
    let description: String?
    let characterCredits: [ReferenceModel]
    let coverDate: String?
    let deck: String?
    let image: ImageModel
    let issueNumber: String
    let locationCredits: [ReferenceModel]
    let objectCredits: [ReferenceModel]
    let personCredits: [PersonCreditModel]
    let siteDetailUrl: String
    let storeDate: String?
    let storyArcCredits: [ReferenceModel]
    let teamCredits: [ReferenceModel]
    let teamDisbandedIn: [ReferenceModel]
    let volume: ReferenceModel

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case characterCredits = "character_credits"
        case coverDate = "cover_date"
        case deck
        case image
        case issueNumber = "issue_number"
        case locationCredits = "location_credits"
        case objectCredits = "object_credits"
        case personCredits = "person_credits"
        case siteDetailUrl = "site_detail_url"
        case storeDate = "store_date"
        case storyArcCredits = "story_arc_credits"
        case teamCredits = "team_credits"
        case teamDisbandedIn = "team_disbanded_in"
        case volume
    }
}

extension IssueDetailsModel {
    struct PersonCreditModel: Codable, Sendable {
        let id: Int
        let name: String?
        let role: String?
        let siteDetailUrl: String?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case role
            case siteDetailUrl = "site_detail_url"
        }
    }
}
