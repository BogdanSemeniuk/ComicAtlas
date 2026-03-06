//
//  FirebaseUserDTO.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 06.03.2026.
//

import FirebaseAuth

struct FirebaseUserDTO {
    let uid: String
    let email: String?
    let displayName: String?
    
    init(_ user: User) {
        self.uid = user.uid
        self.email = user.email
        self.displayName = user.displayName
    }
}
