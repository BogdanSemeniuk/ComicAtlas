//
//  VolumeDetails.swift
//  ComicAtlas
//
//  Created by Codex on 27.03.2026.
//

import Foundation

struct VolumeDetails: Identifiable, Hashable {
    let id: Int
    let name: String
    let aliases: String?
    let characters: [Reference]
    let countOfIssues: Int
    let deck: String?
    let description: String?
    let firstIssue: IssueReference?
    let issues: [IssueReference]
    let lastIssue: IssueReference?
    let publisher: Reference
    let siteDetailUrl: String
    let startYear: String
    let iconUrl: String
    let smallUrl: String

    init(dto: VolumeDetailsDTO) {
        self.id = dto.id
        self.name = dto.name
        self.aliases = dto.aliases
        self.characters = dto.characters.map { .init(dto: $0) }
        self.countOfIssues = dto.countOfIssues
        self.deck = dto.deck
        self.description = dto.description
        self.firstIssue = dto.firstIssue.map { .init(dto: $0) }
        self.issues = dto.issues.map { .init(dto: $0) }
        self.lastIssue = dto.lastIssue.map { .init(dto: $0) }
        self.publisher = .init(dto: dto.publisher)
        self.siteDetailUrl = dto.siteDetailUrl
        self.startYear = dto.startYear
        self.iconUrl = dto.iconUrl
        self.smallUrl = dto.smallUrl
    }
}

extension VolumeDetails {
    struct IssueReference: Identifiable, Hashable {
        let id: Int
        let name: String?
        let issueNumber: String?

        init(dto: VolumeDetailsDTO.IssueReferenceDTO) {
            self.id = dto.id
            self.name = dto.name
            self.issueNumber = dto.issueNumber
        }
    }
}
