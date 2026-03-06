//
//  ComicAtlasApp.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 02.03.2026.
//

import SwiftUI

@main
struct ComicAtlasApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var delegate
    @State private var signInViewModel = SignInViewModel(inputValidator: InputValidator())
    
    var body: some Scene {
        WindowGroup {
            SignInView(model: signInViewModel)
        }
    }
}
