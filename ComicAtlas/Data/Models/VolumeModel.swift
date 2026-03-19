//
//  VolumeModel.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 18.03.2026.
//

import Foundation

nonisolated
struct VolumesResponse: Decodable {
    let volumes: [VolumeModel]

    enum CodingKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.volumes = try container.decode([VolumeModel].self, forKey: .results)
    }
}

struct VolumeModel: Codable, Sendable {
    let id: Int
    let name: String
    let description: String?
    let countOfIssues: Int?
    let image: ImageModel
    let publisher: PublisherModel
    let startYear: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image
        case countOfIssues = "count_of_issues"
        case publisher
        case startYear = "start_year"
    }
}
