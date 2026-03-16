//
//  NetworkBody.swift
//  ComicAtlas
//

import Foundation

struct NetworkBody: Sendable {
    let data: Data
    let contentType: String

    static func json<T: Encodable & Sendable>(
        _ value: T,
        encoder: JSONEncoder = .init()
    ) throws -> NetworkBody {
        try .init(data: encoder.encode(value), contentType: "application/json")
    }

    static func raw(_ data: Data, contentType: String) -> NetworkBody {
        .init(data: data, contentType: contentType)
    }
}
