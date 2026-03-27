//
//  IssueDetailsDTO.swift
//  ComicAtlas
//
//  Created by Codex on 27.03.2026.
//

import Foundation

struct IssueDetailsDTO {
    let id: Int
    let name: String?
    let description: String?
    let characterCredits: [ReferenceDTO]
    let coverDate: String
    let deck: String?
    let issueNumber: String
    let locationCredits: [ReferenceDTO]
    let objectCredits: [ReferenceDTO]
    let personCredits: [PersonCreditDTO]
    let siteDetailUrl: String
    let storeDate: String?
    let storyArcCredits: [ReferenceDTO]
    let teamCredits: [ReferenceDTO]
    let teamDisbandedIn: [ReferenceDTO]
    let volume: ReferenceDTO
    let iconUrl: String
    let smallUrl: String

    init(_ issueDetails: IssueDetailsModel) {
        self.id = issueDetails.id
        self.name = issueDetails.name
        self.description = issueDetails.description
        self.characterCredits = issueDetails.characterCredits.map { .init($0) }
        self.coverDate = issueDetails.coverDate
        self.deck = issueDetails.deck
        self.issueNumber = issueDetails.issueNumber
        self.locationCredits = issueDetails.locationCredits.map { .init($0) }
        self.objectCredits = issueDetails.objectCredits.map { .init($0) }
        self.personCredits = issueDetails.personCredits.map { .init($0) }
        self.siteDetailUrl = issueDetails.siteDetailUrl
        self.storeDate = issueDetails.storeDate
        self.storyArcCredits = issueDetails.storyArcCredits.map { .init($0) }
        self.teamCredits = issueDetails.teamCredits.map { .init($0) }
        self.teamDisbandedIn = issueDetails.teamDisbandedIn.map { .init($0) }
        self.volume = .init(issueDetails.volume)
        self.iconUrl = issueDetails.image.iconUrl
        self.smallUrl = issueDetails.image.smallUrl
    }
}

extension IssueDetailsDTO {
    struct PersonCreditDTO {
        let id: Int
        let name: String?
        let role: String?
        let siteDetailUrl: String?

        init(_ personCredit: IssueDetailsModel.PersonCreditModel) {
            self.id = personCredit.id
            self.name = personCredit.name
            self.role = personCredit.role
            self.siteDetailUrl = personCredit.siteDetailUrl
        }
    }
}
