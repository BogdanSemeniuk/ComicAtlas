//
//  VolumeRepositoryImpl.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 18.03.2026.
//

import Foundation

struct VolumeRepositoryImpl: VolumeRepository {
    let api: APIClientProtocol
    
    func fetchVolumes(limit: Int, offset: Int) async throws -> [Volume] {
        try await api.request(
            APIEndpoints.volumes(limit: limit, offset: offset),
            as: VolumesResponse.self
        )
        .volumes
        .map { .init(dto: .init($0)) }
    }
}
