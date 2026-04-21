//
//  SortDescriptor.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 20.04.2026.
//

import Foundation

enum SortDescriptor: String, CollectionItemRepresentable {
    var id: Self {
        self
    }
    
    case `default`
    case nameAscending
    case nameDescending
    case dateAscending
    case dateDescending
    
    var description: String {
        switch self {
        case .default: .init(localized: .Common.sortDefault)
        case .nameAscending: .init(localized: .Common.sortNameAsc)
        case .nameDescending: .init(localized: .Common.sortNameDesc)
        case .dateAscending: .init(localized: .Common.sortDateAsc)
        case .dateDescending: .init(localized: .Common.sortDateDesc)
        }
    }
}

extension SortDescriptor {
    func apiValue(for item: CollectionItem) -> String? {
        switch self {
        case .default:
            nil
        case .nameAscending:
            "name:asc"
        case .nameDescending:
            "name:desc"
        case .dateAscending:
            "\(dateField(for: item)):asc"
        case .dateDescending:
            "\(dateField(for: item)):desc"
        }
    }
    
    private func dateField(for item: CollectionItem) -> String {
        switch item {
        case .character:
            "date_added"
        case .volume:
            "start_year"
        case .issue:
            "cover_date"
        case .movie:
            "release_date"
        }
    }
}
