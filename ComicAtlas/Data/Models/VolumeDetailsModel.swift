//
//  VolumeDetailsModel.swift
//  ComicAtlas
//
//  Created by Codex on 27.03.2026.
//

import Foundation

nonisolated
struct VolumeDetailsResponse: Decodable {
    let volumeDetails: VolumeDetailsModel

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.volumeDetails = try container.decode(VolumeDetailsModel.self, forKey: .results)
    }
}

struct VolumeDetailsModel: Codable, Sendable {
    let id: Int
    let name: String
    let aliases: String?
    let countOfIssues: Int
    let deck: String?
    let description: String?
    let firstIssue: IssueReferenceModel?
    let image: ImageModel
    let issues: [IssueReferenceModel]
    let lastIssue: IssueReferenceModel?
    let publisher: ReferenceModel
    let siteDetailUrl: String
    let startYear: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case aliases
        case countOfIssues = "count_of_issues"
        case deck
        case description
        case firstIssue = "first_issue"
        case image
        case issues
        case lastIssue = "last_issue"
        case publisher
        case siteDetailUrl = "site_detail_url"
        case startYear = "start_year"
    }
}

extension VolumeDetailsModel {
    struct IssueReferenceModel: Codable, Sendable {
        let id: Int
        let name: String?
        let issueNumber: String?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case issueNumber = "issue_number"
        }
    }
}
