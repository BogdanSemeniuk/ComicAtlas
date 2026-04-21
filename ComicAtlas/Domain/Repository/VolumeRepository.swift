//
//  VolumeRepository.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 18.03.2026.
//

import Foundation

protocol VolumeRepository {
    func fetchVolumes(limit: Int, offset: Int, sort: SortDescriptor) async throws -> [Volume]
    func fetchVolumeDetails(id: Int) async throws -> VolumeDetails
}
