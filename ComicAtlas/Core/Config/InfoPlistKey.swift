//
//  InfoPlistKey.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 13.03.2026.
//

import Foundation

enum InfoPlistKey: String {
    case baseURL = "BASE_URL"
    case apiKey = "API_KEY"
}

extension Bundle {
    func infoPlistValue<T>(forKey key: InfoPlistKey) -> T {
        guard let value = object(forInfoDictionaryKey: key.rawValue) as? T else {
            fatalError(.init(localized: .Error.infoPlistKey(key.rawValue)))
        }
        return value
    }
}
