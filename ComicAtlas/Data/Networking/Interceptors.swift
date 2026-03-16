//
//  Interceptors.swift
//  ComicAtlas
//

import Foundation

protocol NetworkInterceptor: Sendable {
    func intercept(_ request: URLRequest) async throws -> URLRequest
}

enum Interceptors {
    nonisolated static let `default`: [any NetworkInterceptor] = [
        AcceptHeaderInterceptor()
    ]
}

private struct AcceptHeaderInterceptor: NetworkInterceptor {
    func intercept(_ request: URLRequest) async throws -> URLRequest {
        var updatedRequest = request
        if updatedRequest.value(forHTTPHeaderField: "Accept") == nil {
            updatedRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        return updatedRequest
    }
}
