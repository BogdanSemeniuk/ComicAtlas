//
//  IssueRepository.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 19.03.2026.
//

import Foundation

protocol IssueRepository {
    func fetchIssues(limit: Int, offset: Int) async throws -> [Issue]
}
