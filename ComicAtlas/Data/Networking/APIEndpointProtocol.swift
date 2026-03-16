//
//  APIEndpointProtocol.swift
//  ComicAtlas
//

import Foundation

nonisolated
protocol APIEndpointProtocol: Sendable {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String] { get }
    var urlParams: [String: String]? { get }
    var body: NetworkBody? { get }
}

nonisolated
extension APIEndpointProtocol {
    var urlRequest: URLRequest? {
        guard let url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body?.data

        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }

    private var url: URL? {
        guard
            let base = URL(string: baseURL),
            var components = URLComponents(url: base, resolvingAgainstBaseURL: false)
        else {
            return nil
        }

        components.path = normalizedPath(
            basePath: components.path,
            endpointPath: path
        )

        components.queryItems = urlParams?
            .sorted { $0.key < $1.key }
            .map { URLQueryItem(name: $0.key, value: $0.value) }

        return components.url
    }

    private func normalizedPath(basePath: String, endpointPath: String) -> String {
        let base = basePath.split(separator: "/")
        let endpoint = endpointPath.split(separator: "/")

        var result = "/" + (base + endpoint).joined(separator: "/")

        if endpointPath.hasSuffix("/") && !result.hasSuffix("/") {
            result += "/"
        }

        return result
    }
}
