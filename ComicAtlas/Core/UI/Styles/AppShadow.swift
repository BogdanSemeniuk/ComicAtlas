//
//  AppShadow.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

struct AppShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.15), radius: 5)
    }
}

extension View {
    func appShadow() -> some View {
        modifier(AppShadow())
    }
}
