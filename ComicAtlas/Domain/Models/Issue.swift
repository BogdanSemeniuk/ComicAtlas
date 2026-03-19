//
//  Issue.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

struct Issue: Identifiable, Hashable {
    let id: Int
    let name: String?
    let description: String?
    let issueNumber: String
    let iconUrl: String
    let smallUrl: String
    let volumeName: String
    let coverDate: String

    init(dto: IssueDTO) {
        self.id = dto.id
        self.name = dto.name
        self.description = dto.description
        self.issueNumber = dto.issueNumber
        self.iconUrl = dto.iconUrl
        self.smallUrl = dto.smallUrl
        self.volumeName = dto.volumeName
        self.coverDate = dto.coverDate
    }
}
