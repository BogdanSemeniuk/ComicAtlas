//
//  AppContainer.swift
//  ComicAtlas
//
//  Created by Богдан Семенюк on 08.03.2026.
//

import FirebaseAuth
import Foundation

protocol Resolving {
    func resolve<T>() -> T
}

final class AppContainer: Resolving {
    static let shared = AppContainer()
    
    private init() {
        registerDependencies()
    }
    
    private enum Dependency {
        case singleton(Any)
        case factory(() -> Any)
    }
    
    private var dependencies: [String: Dependency] = [:]
    
    func registerSingleton<T>(_ type: T.Type = T.self, _ builder: @autoclosure () -> T) {
        dependencies[.init(describing: type)] = .singleton(builder())
    }
    
    func registerFactory<T>(_ type: T.Type = T.self, _ builder: @escaping () -> T) {
        dependencies[.init(describing: type)] = .factory(builder)
    }
    
    func resolve<T>() -> T {
        guard let entry = dependencies[.init(describing: T.self)] else {
            fatalError(message(.init(describing: T.self)))
        }
        switch entry {
        case .singleton(let object):
            guard let object = object as? T else {
                fatalError(message(.init(describing: T.self)))
            }
            return object
        case .factory(let factory):
            guard let object = factory() as? T else {
                fatalError(message(.init(describing: T.self)))
            }
            return object
        }
    }
    
    private func message(_ type: String) -> String {
        .init(localized: .Error.diContainer(type))
    }
}

extension AppContainer {
    private func registerDependencies() {
        registerFactory(InputValidating.self, { InputValidator() })
        registerFactory(AuthHandler.self, { Auth.auth() })
        registerFactory(AuthService.self, { FirebaseAuthService(authHandler: self.resolve()) })
        registerFactory(AuthRepository.self, { AuthRepositoryImpl(authService: self.resolve()) })
    }
}
