//
//  SignInViewModelTests.swift
//  ComicAtlasTests
//
//  Created by Богдан Семенюк on 21.05.2026.
//

@testable import ComicAtlas
import Testing

@Suite("SignInViewModel tests")
struct SignInViewModelTests {
    @Test
    func inputsChange() {
        let (sut, _, _) = makeSUT()
        let (email, password) = setBaseInputs(to: sut)
        
        #expect(sut.email == email)
        #expect(sut.password == password)
    }
    
    @Test
    func inputsNonEmptySignInEnabled() {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut)
        
        #expect(sut.isSignInDisabled == false)
    }
    
    @Test
    func emptyEmailSignInDisabled() {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut, email: "")
        
        #expect(sut.isSignInDisabled)
    }
    
    @Test
    func emptyPasswordSignInDisabled() {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut, password: "")
        
        #expect(sut.isSignInDisabled)
    }
    
    @Test
    func signInWithInvalidEmail() async {
        let (sut, authService, _) = makeSUT()
        setBaseInputs(to: sut, email: "as")
        
        #expect(sut.isSignInDisabled == false)
        await sut.signInAction()
        #expect(sut.emailError.isEmpty == false)
        #expect(authService.signInCallCount == 0)
    }
    
    @Test(arguments: [
        ("12345", ValidationError.passwordLength),
        ("abcdefgh", .passwordDigit),
        ("abcd1234", .passwordUppercaseLetter),
        ("Abcd 1234", .passwordSpace)
    ])
    func signInWithInvalidPassword(password: String, validationError: ValidationError) async throws {
        let (sut, authService, _) = makeSUT()
        setBaseInputs(to: sut, password: password)
        
        #expect(sut.isSignInDisabled == false)
        await sut.signInAction()
        let errorDescription = try #require(validationError.errorDescription)
        #expect(sut.passwordError == errorDescription)
        #expect(authService.signInCallCount == 0)
    }
    
    @Test
    func signInFail() async throws {
        let (sut, _, _) = makeSUT(shouldThrowError: true)
        setBaseInputs(to: sut)
        
        #expect(sut.isSignInDisabled == false)
        await sut.signInAction()
        let error = try #require(sut.error as? TestError)
        #expect(error == .expectedFailure)
    }
    
    @Test
    func stopLoadingAfterFailedSignIn() async {
        let (sut, _, _) = makeSUT(shouldThrowError: true)
        setBaseInputs(to: sut)
        
        #expect(sut.isSignInDisabled == false)
        await sut.signInAction()
        #expect(sut.isLoading == false)
    }
    
    @Test
    func stopLoadingAfterSucceededSignIn() async {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut)
        
        #expect(sut.isSignInDisabled == false)
        await sut.signInAction()
        #expect(sut.isLoading == false)
    }
    
    @Test
    func successSignIn() async {
        let (sut, authService, _) = makeSUT()
        setBaseInputs(to: sut)
        
        #expect(sut.isSignInDisabled == false)
        await sut.signInAction()
        #expect(sut.error == nil)
        #expect(sut.emailError.isEmpty)
        #expect(sut.passwordError.isEmpty)
        #expect(sut.isLoading == false)
        #expect(authService.isAuthenticated)
        #expect(authService.signInCallCount == 1)
        #expect(authService.receivedEmail == sut.email)
        #expect(authService.receivedPassword == sut.password)
    }
    
    @Test
    func clearErrorAfterTypingEmail() async {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut, email: "as")
        
        #expect(sut.isSignInDisabled == false)
        await sut.signInAction()
        #expect(sut.emailError.isEmpty == false)
        sut.email = "a"
        #expect(sut.emailError.isEmpty)
    }
    
    @Test
    func clearErrorAfterTypingPassword() async {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut, password: "as")
        
        #expect(sut.isSignInDisabled == false)
        await sut.signInAction()
        #expect(sut.passwordError.isEmpty == false)
        sut.password = "a"
        #expect(sut.passwordError.isEmpty)
    }
    
    @Test
    func navigateToSignUp() {
        let (sut, _, navigationHandler) = makeSUT()
        
        sut.signUpAction()
        #expect(navigationHandler.navigationToCallCount == 1)
        #expect(navigationHandler.path == [.signUp])
    }
    
    @discardableResult
    func setBaseInputs(
        to sut: SignInViewModel,
        email: String = "abc@gmail.com",
        password: String = "Abcd1234"
    ) -> (email: String, password: String)
    {
        sut.email = email
        sut.password = password
        return (sut.email, sut.password)
    }
    
    func makeSUT(isLoggedIn: Bool = false, shouldThrowError: Bool = false) -> (
        SignInViewModel,
        AuthServiceMock,
        NavigationHandlerMock<AuthFlowCoordinator.Route>
    ) {
        let authService = AuthServiceMock(isLoggedIn: isLoggedIn, shouldThrowError: shouldThrowError)
        let authRepository = AuthRepositoryImpl(authService: authService)
        let navigationHandler = NavigationHandlerMock<AuthFlowCoordinator.Route>()
        return (
            .init(inputValidator: InputValidator(), authRepository: authRepository, navigationHandler: navigationHandler),
            authService,
            navigationHandler
        )
    }
}
