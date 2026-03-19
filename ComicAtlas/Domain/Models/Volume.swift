//
//  Volume.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 18.03.2026.
//

import Foundation

struct Volume: Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String?
    let iconUrl: String
    let smallUrl: String
    let countOfIssues: Int?
    let publisherName: String
    let startYear: String
    var issuesCountDescription: String? {
        guard let countOfIssues else { return nil }
        return String(localized: .Common.issuesCount(Int32(countOfIssues)))
    }
    
    init(dto: VolumeDTO) {
        self.id = dto.id
        self.name = dto.name
        self.description = dto.description
        self.startYear = dto.startYear
        self.publisherName = dto.publisherName
        self.countOfIssues = dto.countOfIssues
        self.iconUrl = dto.iconUrl
        self.smallUrl = dto.smallUrl
    }
}
