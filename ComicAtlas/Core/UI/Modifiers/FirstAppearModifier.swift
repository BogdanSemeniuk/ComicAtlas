//
//  FirstAppearModifier.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 26.03.2026.
//

import SwiftUI

private struct FirstAppear: ViewModifier {
    let action: () -> ()
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !hasAppeared else { return }
                hasAppeared = true
                action()
            }
    }
}

extension View {
    func onFirstAppear(_ action: @escaping () -> ()) -> some View {
        modifier(FirstAppear(action: action))
    }
}
