//
//  APIEndpoints.swift
//  ComicAtlas
//

import Foundation

private enum Constants {
    static let charactersPath = "characters/"
    static let volumesPath = "volumes/"
    static let issuesPath = "issues/"
    static let moviesPath = "movies/"
    static let formatJSON = "json"
    static let contentTypeHeader = "Content-Type"
}

enum APIEndpoints: Sendable {
    case characters(limit: Int, offset: Int)
    case volumes(limit: Int, offset: Int)
    case issues(limit: Int, offset: Int)
    case movies(limit: Int, offset: Int)
}

extension APIEndpoints: APIEndpointProtocol {
    var baseURL: String {
        AppEnvironment.baseURL
    }
    
    var method: HTTPMethod {
        switch self {
        case .characters, .volumes, .issues, .movies:
                .get
        }
    }
    
    var path: String {
        switch self {
        case .characters:
            Constants.charactersPath
        case .volumes:
            Constants.volumesPath
        case .issues:
            Constants.issuesPath
        case .movies:
            Constants.moviesPath
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
        case let .characters(limit, offset),
            let .volumes(limit, offset),
            let .issues(limit, offset),
            let .movies(limit, offset):
            [
                "api_key": AppEnvironment.apiKey,
                "format": Constants.formatJSON,
                "limit": String(limit),
                "offset": String(offset)
            ]
        }
    }
    
    var body: NetworkBody? {
        switch self {
        case .characters, .volumes, .issues, .movies:
            nil
        }
    }
}
