//
//  APIEndpoints.swift
//  ComicAtlas
//

import Foundation

private enum Constants {
    static let apiPath = "/api"
    static let charactersPath = "characters/"
    static let characterDetailsPathPrefix = "character/4005-"
    static let issueDetailsPathPrefix = "issue/4000-"
    static let movieDetailsPathPrefix = "movie/4025-"
    static let volumeDetailsPathPrefix = "volume/4050-"
    static let volumesPath = "volumes/"
    static let issuesPath = "issues/"
    static let moviesPath = "movies/"
    static let formatJSON = "json"
    static let contentTypeHeader = "Content-Type"
}

enum APIEndpoints: Sendable {
    case characters(limit: Int, offset: Int, sort: SortDescriptor)
    case characterDetails(id: Int)
    case issueDetails(id: Int)
    case movieDetails(id: Int)
    case volumeDetails(id: Int)
    case volumes(limit: Int, offset: Int, sort: SortDescriptor)
    case issues(limit: Int, offset: Int, sort: SortDescriptor)
    case movies(limit: Int, offset: Int, sort: SortDescriptor)
}

extension APIEndpoints: APIEndpointProtocol {
    var baseURL: String {
        AppEnvironment.baseURL.appending(Constants.apiPath)
    }
    
    var method: HTTPMethod {
        switch self {
        case .characters, .characterDetails, .issueDetails, .movieDetails, .volumeDetails, .volumes, .issues, .movies:
                .get
        }
    }
    
    var path: String {
        switch self {
        case .characters:
            Constants.charactersPath
        case let .characterDetails(id):
            "\(Constants.characterDetailsPathPrefix)\(id)/"
        case let .issueDetails(id):
            "\(Constants.issueDetailsPathPrefix)\(id)/"
        case let .movieDetails(id):
            "\(Constants.movieDetailsPathPrefix)\(id)/"
        case let .volumeDetails(id):
            "\(Constants.volumeDetailsPathPrefix)\(id)/"
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
        case let .characters(limit, offset, sort):
            listURLParams(limit: limit, offset: offset, sort: sort, item: .character)
        case let .volumes(limit, offset, sort):
            listURLParams(limit: limit, offset: offset, sort: sort, item: .volume)
        case let .issues(limit, offset, sort):
            listURLParams(limit: limit, offset: offset, sort: sort, item: .issue)
        case let .movies(limit, offset, sort):
            listURLParams(limit: limit, offset: offset, sort: sort, item: .movie)
        case .characterDetails, .issueDetails, .movieDetails, .volumeDetails:
            [
                "api_key": AppEnvironment.apiKey,
                "format": Constants.formatJSON
            ]
        }
    }
    
    var body: NetworkBody? {
        switch self {
        case .characters, .characterDetails, .issueDetails, .movieDetails, .volumeDetails, .volumes, .issues, .movies:
            nil
        }
    }
}

private extension APIEndpoints {
    func listURLParams(
        limit: Int,
        offset: Int,
        sort: SortDescriptor,
        item: CollectionItem
    ) -> [String: String] {
        var params = [
            "api_key": AppEnvironment.apiKey,
            "format": Constants.formatJSON,
            "limit": String(limit),
            "offset": String(offset)
        ]
        if let sortValue = sort.apiValue(for: item) {
            params["sort"] = sortValue
        }
        return params
    }
}
