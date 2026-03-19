//
//  IssueModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

nonisolated
struct IssuesResponse: Decodable {
    let issues: [IssueModel]

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.issues = try container.decode([IssueModel].self, forKey: .results)
    }
}

struct IssueModel: Codable, Sendable {
    let id: Int
    let name: String?
    let description: String?
    let issueNumber: String
    let image: ImageModel
    let volume: VolumeShortModel
    let coverDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case issueNumber = "issue_number"
        case image
        case volume
        case coverDate = "cover_date"
    }
}
