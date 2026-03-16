//
//  APIEndpoints.swift
//  ComicAtlas
//

import Foundation

private enum Constants {
    static let charactersPath = "characters/"
    static let formatJSON = "json"
    static let contentTypeHeader = "Content-Type"
}

enum APIEndpoints: Sendable {
    case characters
}

extension APIEndpoints: APIEndpointProtocol {
    var baseURL: String {
        AppEnvironment.baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .characters:
                .get
        }
    }
    
    var path: String {
        switch self {
        case .characters:
            Constants.charactersPath
        }
    }
    
    var headers: [String: String] {
        guard let body else {
            return [:]
        }
        return [Constants.contentTypeHeader: body.contentType]
    }
    
    var urlParams: [String: String]? {
        switch self {
        case .characters:
            [
                "api_key": AppEnvironment.apiKey,
                "format": Constants.formatJSON
            ]
        }
    }
    
    var body: NetworkBody? {
        switch self {
        case .characters:
            nil
        }
    }
}
