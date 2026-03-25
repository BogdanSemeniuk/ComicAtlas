//
//  Gender.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 25.03.2026.
//

import Foundation

enum Gender: Int {
    case male = 1
    case female = 2
    
    var description: String {
        switch self {
        case .male: .init(localized: .Common.male)
        case .female: .init(localized: .Common.female)
        }
    }
}
