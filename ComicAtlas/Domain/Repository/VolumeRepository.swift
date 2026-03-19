//
//  VolumeRepository.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 18.03.2026.
//

import Foundation

protocol VolumeRepository {
    func fetchVolumes(limit: Int, offset: Int) async throws -> [Volume]
}
