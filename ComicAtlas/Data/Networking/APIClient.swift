//
//  APIClient.swift
//  ComicAtlas
//

import Foundation

struct APIClient: APIClientProtocol {
    private let session: URLSession
    private let interceptors: [any NetworkInterceptor]

    init(
        session: URLSession = .shared,
        interceptors: [any NetworkInterceptor] = Interceptors.default
    ) {
        self.session = session
        self.interceptors = interceptors
    }

    func request<T: Decodable & Sendable>(
        _ endpoint: any APIEndpointProtocol,
        as type: T.Type,
        decoder: JSONDecoder
    ) async throws -> T {
        let (data, _) = try await requestRaw(endpoint)

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkingError.decodingError
        }
    }

    func request(_ endpoint: any APIEndpointProtocol) async throws {
        _ = try await requestRaw(endpoint)
    }

    func requestRaw(_ endpoint: any APIEndpointProtocol) async throws -> (Data, URLResponse) {
        let request = try await makeRequest(for: endpoint)

        do {
            let (data, response) = try await session.data(for: request)
            try validate(response: response)
            return (data, response)
        } catch let urlError as URLError where urlError.code == .notConnectedToInternet {
            throw NetworkingError.networkUnavailable
        } catch let error as NetworkingError {
            throw error
        } catch {
            throw NetworkingError.requestFailed(error.localizedDescription)
        }
    }

    private func makeRequest(for endpoint: any APIEndpointProtocol) async throws -> URLRequest {
        guard var request = endpoint.urlRequest else {
            throw NetworkingError.invalidURL
        }

        for interceptor in interceptors {
            request = try await interceptor.intercept(request)
        }

        return request
    }

    private func validate(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingError.requestFailed("Invalid HTTP response")
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkingError.serverError(httpResponse.statusCode)
        }
    }
}
