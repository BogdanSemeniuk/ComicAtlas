//
//  IssueDetails.swift
//  ComicAtlas
//
//  Created by Codex on 27.03.2026.
//

import Foundation

struct IssueDetails: Identifiable, Hashable {
    let id: Int
    let name: String?
    let description: String?
    let characterCredits: [Reference]
    let coverDate: String?
    let deck: String?
    let issueNumber: String
    let locationCredits: [Reference]
    let objectCredits: [Reference]
    let personCredits: [PersonCredit]
    let siteDetailUrl: String
    let storeDate: String?
    let storyArcCredits: [Reference]
    let teamCredits: [Reference]
    let teamDisbandedIn: [Reference]
    let volume: Reference
    let iconUrl: String
    let smallUrl: String
    
    var title: String {
        let volumeName = volume.name ?? ""
        return "\(volumeName) #\(issueNumber)"
    }

    init(dto: IssueDetailsDTO) {
        self.id = dto.id
        self.name = dto.name
        self.description = dto.description
        self.characterCredits = dto.characterCredits.map { .init(dto: $0) }
        self.coverDate = dto.coverDate
        self.deck = dto.deck
        self.issueNumber = dto.issueNumber
        self.locationCredits = dto.locationCredits.map { .init(dto: $0) }
        self.objectCredits = dto.objectCredits.map { .init(dto: $0) }
        self.personCredits = dto.personCredits.map { .init(dto: $0) }
        self.siteDetailUrl = dto.siteDetailUrl
        self.storeDate = dto.storeDate
        self.storyArcCredits = dto.storyArcCredits.map { .init(dto: $0) }
        self.teamCredits = dto.teamCredits.map { .init(dto: $0) }
        self.teamDisbandedIn = dto.teamDisbandedIn.map { .init(dto: $0) }
        self.volume = .init(dto: dto.volume)
        self.iconUrl = dto.iconUrl
        self.smallUrl = dto.smallUrl
    }
}

extension IssueDetails {
    struct PersonCredit: Identifiable, Hashable {
        let id: Int
        let name: String?
        let role: String?
        let siteDetailUrl: String?

        init(dto: IssueDetailsDTO.PersonCreditDTO) {
            self.id = dto.id
            self.name = dto.name
            self.role = dto.role
            self.siteDetailUrl = dto.siteDetailUrl
        }
    }
}
