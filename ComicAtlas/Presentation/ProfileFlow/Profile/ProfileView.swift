//
//  ProfileView.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 10.03.2026.
//

import SwiftUI

struct ProfileView: View {
    @State private var model: ProfileViewModel
    
    init(model: ProfileViewModel) {
        self._model = State(initialValue: model)
    }
    
    var body: some View {
        Button("Logout", action: model.logoutAction)
    }
}
