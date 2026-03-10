//
//  SystemImage.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

enum SystemImage: String {
    case eye
    case calendar
    case eyeSlash = "eye.slash"
    case xmarkCircleFill = "xmark.circle.fill"
    case xmark
    case personRectangle = "person.text.rectangle"
    case house = "house"
}

extension Image {
    init(si systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)
    }
}
