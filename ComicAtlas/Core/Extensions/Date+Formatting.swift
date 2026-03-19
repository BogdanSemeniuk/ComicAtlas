//
//  Date+Formatting.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

enum DateFormat: String {
    case yyyyMMdd = "yyyy-MM-dd"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case monthYear = "MMMM yyyy"
}

extension DateFormatter {
    private static var cache: [DateFormat: DateFormatter] = [:]

    static func cached(format: DateFormat) -> DateFormatter {
        if let formatter = cache[format] {
            return formatter
        }

        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")

        cache[format] = formatter
        return formatter
    }
}

extension String {
    func toDate(format: DateFormat) -> Date? {
        DateFormatter.cached(format: format).date(from: self)
    }
}

extension Date {
    func toString(format: DateFormat) -> String {
        DateFormatter.cached(format: format).string(from: self)
    }
}
