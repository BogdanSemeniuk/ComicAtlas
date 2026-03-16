//
//  UserInfo.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 06.03.2026.
//

import Foundation

struct UserInfo {
    let id: String
    let email: String?
    let displayName: String?
    
    init(dto: FirebaseUserDTO) {
        self.id = dto.uid
        self.email = dto.email
        self.displayName = dto.displayName
    }
}
