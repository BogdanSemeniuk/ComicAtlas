//
//  IssueReferenceModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 24.03.2026.
//

import Foundation

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
