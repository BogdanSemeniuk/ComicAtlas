//
//  VolumeDTO.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 18.03.2026.
//

import Foundation

struct VolumeDTO {
    let id: Int
    let name: String
    let description: String?
    let iconUrl: String
    let smallUrl: String
    let countOfIssues: Int?
    let publisherName: String
    let startYear: String
    
    init(_ volume: VolumeModel) {
        self.id = volume.id
        self.name = volume.name
        self.description = volume.description
        self.publisherName = volume.publisher.name
        self.countOfIssues = volume.countOfIssues
        self.iconUrl = volume.image.smallUrl
        self.smallUrl = volume.image.smallUrl
        self.startYear = volume.startYear
    }
}
