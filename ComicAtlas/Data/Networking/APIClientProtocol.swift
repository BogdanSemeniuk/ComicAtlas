//
//  APIClientProtocol.swift
//  ComicAtlas
//

import Foundation

protocol APIClientProtocol: Sendable {
    func request<T: Decodable & Sendable>(
        _ endpoint: any APIEndpointProtocol,
        as type: T.Type,
        decoder: JSONDecoder
    ) async throws -> T

    func request(_ endpoint: any APIEndpointProtocol) async throws
    func requestRaw(_ endpoint: any APIEndpointProtocol) async throws -> (Data, URLResponse)
}

extension APIClientProtocol {
    func request<T: Decodable & Sendable>(
        _ endpoint: any APIEndpointProtocol,
        as type: T.Type = T.self,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        try await request(endpoint, as: type, decoder: decoder)
    }
}
