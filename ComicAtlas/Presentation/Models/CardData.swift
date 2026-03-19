//
//  CardData.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

struct CardData: Identifiable {
    let id: String
    let itemId: Int
    let title: String
    let desctiption: String?
    let imageURL: String
    let type: CollectionItem
    
    init(_ character: Character) {
        self.desctiption = nil
        self.title = character.name
        self.imageURL = character.smallUrl
        self.type = .character
        self.itemId = character.id
        self.id = "\(character.id)\(type.rawValue)"
    }
    
    init(_ volume: Volume) {
        self.title = volume.name
        self.imageURL = volume.smallUrl
        self.type = .volume
        self.itemId = volume.id
        self.id = "\(volume.id)\(type.rawValue)"
        self.desctiption = [
            volume.startYear,
            volume.publisherName,
            volume.issuesCountDescription
        ]
            .compactMap({ $0 })
            .joined(separator: "\n")
    }
    
    init(_ issue: Issue) {
        self.title = issue.volumeName + " #\(issue.issueNumber)"
        self.imageURL = issue.smallUrl
        self.type = .issue
        self.itemId = issue.id
        self.id = "\(issue.id)\(type.rawValue)"
        self.desctiption = issue.coverDate.toDate(format: .yyyyMMdd)?.toString(format: .monthYear)
    }
    
    init(_ movie: Movie) {
        self.title = movie.name
        self.imageURL = movie.smallUrl
        self.type = .movie
        self.itemId = movie.id
        self.id = "\(movie.id)\(type.rawValue)"
        self.desctiption = movie.releaseDate
            .toDate(format: .yyyyMMddHHmmss)?
            .toString(format: .monthYear) ?? "" + "\n" + movie.studios.joined(separator: ", ")
    }
}
