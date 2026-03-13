//
//  AppEnvironment.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 13.03.2026.
//

import Foundation

enum AppEnvironment {
    static let apiKey: String = Bundle.main.infoPlistValue(forKey: .apiKey)
    static let baseURL: String = Bundle.main.infoPlistValue(forKey: .baseURL)
}
