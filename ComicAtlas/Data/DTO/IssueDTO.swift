//
//  IssueDTO.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

struct IssueDTO {
    let id: Int
    let name: String?
    let description: String?
    let issueNumber: String
    let iconUrl: String
    let smallUrl: String
    let volumeName: String
    let coverDate: String

    init(_ issue: IssueModel) {
        self.id = issue.id
        self.name = issue.name
        self.description = issue.description
        self.issueNumber = issue.issueNumber
        self.iconUrl = issue.image.iconUrl
        self.smallUrl = issue.image.smallUrl
        self.volumeName = issue.volume.name
        self.coverDate = issue.coverDate
    }
}
