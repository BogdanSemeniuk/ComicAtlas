//
//  FirebaseAuthServiceTests.swift
//  ComicAtlasTests
//
//  Created by Богдан Семенюк on 23.03.2026.
//

import Combine
import Testing
@testable import ComicAtlas

@Suite("FirebaseAuthService tests")
struct FirebaseAuthServiceTests {
    @Test
    func isAuthenticatedPublisherUsesInitialAdapterState() async throws {
        let (sut, adapter) = makeSUT(isLoggedIn: true)
        
        for await isAuthenticated in sut.isAuthenticatedPublisher.values {
            #expect(isAuthenticated)
            break
        }
        
        #expect(adapter.isAuthenticatedListenerCallCount == 1)
    }
    
    @Test
    func isAuthenticatedPublisherEmitsUpdatedAuthenticationState() async throws {
        let (sut, adapter) = makeSUT()
        var cancellable: AnyCancellable?
        
        await confirmation { confirmation in
            cancellable = sut.isAuthenticatedPublisher
                .dropFirst()
                .sink { isAuthenticated in
                    #expect(isAuthenticated)
                    confirmation()
                }
            
            adapter.sendAuthenticationState(true)
        }
        cancellable?.cancel()
    }
    
    @Test
    func deinitRemovesStateDidChangeListener() {
        let adapter = FirebaseAuthAdapterMock(isLoggedIn: false, shouldThrowError: false)
        var sut: FirebaseAuthService? = FirebaseAuthService(firebaseAdapter: adapter)
        
        sut = nil
        
        #expect(sut == nil)
        #expect(adapter.removeStateDidChangeListenerCallCount == 1)
        #expect(adapter.removedHandle != nil)
    }
    
    @Test
    func signIn() async throws {
        let (sut, adapter) = makeSUT()
        let email = "test@test.com"
        let password = "password"
        
        await #expect(throws: Never.self) {
            try await sut.signIn(email: email, password: password)
        }
        #expect(adapter.signInCallCount == 1)
        #expect(adapter.receivedSignInEmail == email)
        #expect(adapter.receivedSignInPassword == password)
    }
    
    @Test
    func signInFail() async throws {
        let (sut, adapter) = makeSUT(shouldThrowError: true)
        let email = "test@test.com"
        let password = "password"
        
        await #expect(throws: TestError.expectedFailure) {
            try await sut.signIn(email: email, password: password)
        }
        #expect(adapter.signInCallCount == 1)
        #expect(adapter.receivedSignInEmail == email)
        #expect(adapter.receivedSignInPassword == password)
    }
    
    @Test
    func signOut() {
        let (sut, adapter) = makeSUT(isLoggedIn: true)
        
        #expect(throws: Never.self) {
            try sut.signOut()
        }
        #expect(adapter.signOutCallCount == 1)
    }
    
    @Test
    func signOutFail() {
        let (sut, adapter) = makeSUT(isLoggedIn: true, shouldThrowError: true)
        
        #expect(throws: TestError.expectedFailure) {
            try sut.signOut()
        }
        #expect(adapter.signOutCallCount == 1)
    }
    
    @Test
    func createUser() async throws {
        let (sut, adapter) = makeSUT()
        let email = "test@test.com"
        let password = "password"
        let name = "name"
        
        await #expect(throws: Never.self) {
            let user = try await sut.registerUser(email: email, password: password, name: name)
            #expect(user.email == email && user.displayName == name)
        }
        #expect(adapter.createUserCallCount == 1)
        #expect(adapter.receivedCreateUserEmail == email)
        #expect(adapter.receivedCreateUserPassword == password)
        #expect(adapter.receivedCreateUserName == name)
    }
    
    @Test
    func createUserFail() async throws {
        let (sut, adapter) = makeSUT(shouldThrowError: true)
        let email = "test@test.com"
        let password = "password"
        let name = "name"
        var user: FirebaseUserDTO?
        
        await #expect(throws: TestError.expectedFailure) {
            user = try await sut.registerUser(email: email, password: password, name: name)
        }
        #expect(user == nil)
        #expect(adapter.createUserCallCount == 1)
        #expect(adapter.receivedCreateUserEmail == email)
        #expect(adapter.receivedCreateUserPassword == password)
        #expect(adapter.receivedCreateUserName == name)
    }
    
    private func makeSUT(
        isLoggedIn: Bool = false,
        shouldThrowError: Bool = false
    ) -> (sut: FirebaseAuthService, adapter: FirebaseAuthAdapterMock) {
        let adapter = FirebaseAuthAdapterMock(
            isLoggedIn: isLoggedIn,
            shouldThrowError: shouldThrowError
        )
        return (FirebaseAuthService(firebaseAdapter: adapter), adapter)
    }
}
