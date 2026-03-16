//
//  NetworkingError.swift
//  ComicAtlas
//

import Foundation

enum NetworkingError: Error, LocalizedError, Sendable {
    case invalidURL
    case decodingError
    case serverError(Int)
    case networkUnavailable
    case requestFailed(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            String(localized: .NetworkingError.invalidURL)
        case .decodingError:
            String(localized: .NetworkingError.decodingError)
        case .serverError(let statusCode):
            "\(String(localized: .NetworkingError.serverError)) (\(statusCode))"
        case .networkUnavailable:
            String(localized: .NetworkingError.networkUnavailable)
        case .requestFailed(let reason):
            "\(String(localized: .NetworkingError.requestFailed)): \(reason)"
        }
    }
}
