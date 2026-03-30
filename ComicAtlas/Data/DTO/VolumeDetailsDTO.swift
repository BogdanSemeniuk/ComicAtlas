//
//  VolumeDetailsDTO.swift
//  ComicAtlas
//
//  Created by Codex on 27.03.2026.
//

import Foundation

struct VolumeDetailsDTO {
    let id: Int
    let name: String
    let aliases: String?
    let countOfIssues: Int
    let deck: String?
    let description: String?
    let firstIssue: IssueReferenceDTO?
    let issues: [IssueReferenceDTO]
    let lastIssue: IssueReferenceDTO?
    let publisher: ReferenceDTO
    let siteDetailUrl: String
    let startYear: String
    let iconUrl: String
    let smallUrl: String

    init(_ volumeDetails: VolumeDetailsModel) {
        self.id = volumeDetails.id
        self.name = volumeDetails.name
        self.aliases = volumeDetails.aliases
        self.countOfIssues = volumeDetails.countOfIssues
        self.deck = volumeDetails.deck
        self.description = volumeDetails.description
        self.firstIssue = volumeDetails.firstIssue.map { .init($0) }
        self.issues = volumeDetails.issues.map { .init($0) }
        self.lastIssue = volumeDetails.lastIssue.map { .init($0) }
        self.publisher = .init(volumeDetails.publisher)
        self.siteDetailUrl = volumeDetails.siteDetailUrl
        self.startYear = volumeDetails.startYear
        self.iconUrl = volumeDetails.image.iconUrl
        self.smallUrl = volumeDetails.image.smallUrl
    }
}

extension VolumeDetailsDTO {
    struct IssueReferenceDTO {
        let id: Int
        let name: String?
        let issueNumber: String?

        init(_ issue: VolumeDetailsModel.IssueReferenceModel) {
            self.id = issue.id
            self.name = issue.name
            self.issueNumber = issue.issueNumber
        }
    }
}
