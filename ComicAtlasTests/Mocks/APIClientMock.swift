//
//  APIClientMock.swift
//  ComicAtlasTests
//
//  Created by Codex on 04.06.2026.
//

import Foundation
@testable import ComicAtlas

struct APIClientRequest: Sendable {
    let path: String
    let method: HTTPMethod
    let urlParams: [String: String]?
}

actor APIClientMock: APIClientProtocol {
    private let responseData: Data?
    private let error: (any Error)?
    private(set) var requests: [APIClientRequest] = []
    
    init(
        responseData: Data? = nil,
        error: (any Error)? = nil
    ) {
        self.responseData = responseData
        self.error = error
    }
    
    func request<T: Decodable & Sendable>(
        _ endpoint: any APIEndpointProtocol,
        as type: T.Type,
        decoder: JSONDecoder
    ) async throws -> T {
        record(endpoint)
        if let error {
            throw error
        }
        guard let responseData else {
            throw TestError.expectedFailure
        }
        return try decoder.decode(type, from: responseData)
    }
    
    func request(_ endpoint: any APIEndpointProtocol) async throws {
        record(endpoint)
        guard let error else { return }
        throw error
    }
    
    func requestRaw(_ endpoint: any APIEndpointProtocol) async throws -> (Data, URLResponse) {
        record(endpoint)
        if let error {
            throw error
        }
        let data = responseData ?? Data()
        let url = endpoint.urlRequest?.url ?? .init(string: "https://example.com")!
        let response = URLResponse(
            url: url,
            mimeType: nil,
            expectedContentLength: data.count,
            textEncodingName: nil
        )
        return (data, response)
    }
    
    private func record(_ endpoint: any APIEndpointProtocol) {
        requests.append(
            .init(
                path: endpoint.path,
                method: endpoint.method,
                urlParams: endpoint.urlParams
            )
        )
    }
}
