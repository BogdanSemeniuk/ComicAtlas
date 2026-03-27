//
//  IssueRepositoryImpl.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

struct IssueRepositoryImpl: IssueRepository {
    let api: APIClientProtocol

    func fetchIssues(limit: Int, offset: Int) async throws -> [Issue] {
        try await api.request(
            APIEndpoints.issues(limit: limit, offset: offset),
            as: IssuesResponse.self
        )
        .issues
        .map { .init(dto: .init($0)) }
    }

    func fetchIssueDetails(id: Int) async throws -> IssueDetails {
        let response = try await api.request(
            APIEndpoints.issueDetails(id: id),
            as: IssueDetailsResponse.self
        )

        return .init(dto: .init(response.issueDetails))
    }
}
