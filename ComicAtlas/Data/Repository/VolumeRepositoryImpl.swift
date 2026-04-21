//
//  VolumeRepositoryImpl.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 18.03.2026.
//

import Foundation

struct VolumeRepositoryImpl: VolumeRepository {
    let api: APIClientProtocol
    
    func fetchVolumes(limit: Int, offset: Int, sort: SortDescriptor) async throws -> [Volume] {
        try await api.request(
            APIEndpoints.volumes(limit: limit, offset: offset, sort: sort),
            as: VolumesResponse.self
        )
        .volumes
        .map { .init(dto: .init($0)) }
    }

    func fetchVolumeDetails(id: Int) async throws -> VolumeDetails {
        let response = try await api.request(
            APIEndpoints.volumeDetails(id: id),
            as: VolumeDetailsResponse.self
        )

        return .init(dto: .init(response.volumeDetails))
    }
}
