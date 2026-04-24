//
//  AuthRepositoryTests.swift
//  ComicAtlasTests
//
//  Created by Богдан Семенюк on 21.04.2026.
//

import Combine
@testable import ComicAtlas
import Testing

@Suite("AuthRepository tests")
struct AuthRepositoryTests {
    
    @Test
    func signIn() async throws {
        let (sut, authService) = makeSUT()
        let email = "test@test.com"
        let password = "password"
        var cancellable: Set<AnyCancellable> = []
        
        sut.isAuthenticatedPublisher
            .sink {
                #expect($0)
            }
            .store(in: &cancellable)
        await #expect(throws: Never.self) {
            try await sut.signIn(email: email, password: password)
        }
        
        #expect(authService.isAuthenticated)
        #expect(authService.signInCallCount == 1)
        #expect(authService.receivedEmail == email)
        #expect(authService.receivedPassword == password)
    }
    
    @Test
    func signInFail() async throws {
        let (sut, authService) = makeSUT(shouldThrowError: true)
        let email = "test@test.com"
        let password = "password"
        
        
        await #expect(throws: TestError.expectedFailure) {
            try await sut.signIn(email: email, password: password)
        }
        
        #expect(!authService.isAuthenticated)
        #expect(authService.signInCallCount == 1)
        #expect(authService.receivedEmail == nil)
        #expect(authService.receivedPassword == nil)
    }
    
    @Test
    func signOut() async throws {
        let (sut, authService) = makeSUT(isLoggedIn: true)
        let emittedStateTask = Task { () -> Bool? in
            var iterator = sut.isAuthenticatedPublisher.dropFirst().values.makeAsyncIterator()
            return await iterator.next()
        }
        
        #expect(throws: Never.self) {
            try sut.signOut()
        }
        
        #expect(await emittedStateTask.value == false)
        
        #expect(!authService.isAuthenticated)
        #expect(authService.signOutCallCount == 1)
    }
    
    @Test
    func signOutFail() throws {
        let (sut, authService) = makeSUT(isLoggedIn: true, shouldThrowError: true)
        
        #expect(throws: TestError.expectedFailure) {
            try sut.signOut()
        }
        
        #expect(authService.isAuthenticated)
        #expect(authService.signOutCallCount == 1)
    }
    
    @Test
    func registerUser() async throws {
        let (sut, authService) = makeSUT()
        let email = "test@test.com"
        let password = "password"
        let name = "Alex"
        let emittedStateTask = Task { () -> Bool? in
            var iterator = sut.isAuthenticatedPublisher.dropFirst().values.makeAsyncIterator()
            return await iterator.next()
        }
        
        await #expect(throws: Never.self) {
            let user = try await sut.registerUser(email: email, password: password, name: name)
            #expect(user.email == email)
            #expect(user.displayName == name)
            #expect(user.id == authService.registeredUserId)
        }
        
        #expect(await emittedStateTask.value == true)
        
        #expect(authService.isAuthenticated)
        #expect(authService.registerCallCount == 1)
        #expect(authService.receivedEmail == email)
        #expect(authService.receivedPassword == password)
    }
    
    @Test
    func registerUserFail() async throws {
        let (sut, authService) = makeSUT(shouldThrowError: true)
        let email = "test@test.com"
        let password = "password"
        let name = "Alex"
        
        await #expect(throws: TestError.expectedFailure) {
            try await sut.registerUser(email: email, password: password, name: name)
        }
        
        #expect(!authService.isAuthenticated)
        #expect(authService.registerCallCount == 1)
        #expect(authService.receivedEmail == nil)
        #expect(authService.receivedPassword == nil)
    }
    
    private func makeSUT(
        isLoggedIn: Bool = false,
        shouldThrowError: Bool = false
    ) -> (sut: AuthRepository, authService: AuthServiceMock) {
        let authService = AuthServiceMock(
            isLoggedIn: isLoggedIn,
            shouldThrowError: shouldThrowError
        )
        return (sut: AuthRepositoryImpl(authService: authService), authService: authService)
    }
}
