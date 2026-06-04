//
//  SignUpViewModelTests.swift
//  ComicAtlasTests
//
//  Created by Codex on 04.06.2026.
//

@testable import ComicAtlas
import Testing

@Suite("SignUpViewModel tests")
struct SignUpViewModelTests {
    @Test
    func inputsChange() {
        let (sut, _, _) = makeSUT()
        let inputs = setBaseInputs(to: sut)
        
        #expect(sut.fullName == inputs.fullName)
        #expect(sut.email == inputs.email)
        #expect(sut.password == inputs.password)
        #expect(sut.confirmPassword == inputs.confirmPassword)
    }
    
    @Test
    func inputsNonEmptySignUpEnabled() {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut)
        
        #expect(sut.isSignInDisabled == false)
    }
    
    @Test
    func emptyEmailSignUpDisabled() {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut, email: "")
        
        #expect(sut.isSignInDisabled)
    }
    
    @Test
    func emptyPasswordSignUpDisabled() {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut, password: "")
        
        #expect(sut.isSignInDisabled)
    }
    
    @Test
    func emptyConfirmPasswordSignUpDisabled() {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut, confirmPassword: "")
        
        #expect(sut.isSignInDisabled)
    }
    
    @Test
    func signUpWithInvalidEmail() async throws {
        let (sut, authService, _) = makeSUT()
        setBaseInputs(to: sut, email: "as")
        
        #expect(sut.isSignInDisabled == false)
        await sut.createAccountAction()
        
        #expect(sut.emailError.isEmpty == false)
        #expect(authService.registerCallCount == 0)
    }
    
    @Test(arguments: [
        ("12345", ValidationError.passwordLength),
        ("abcdefgh", .passwordDigit),
        ("abcd1234", .passwordUppercaseLetter),
        ("Abcd 1234", .passwordSpace)
    ])
    func signUpWithInvalidPassword(password: String, validationError: ValidationError) async throws {
        let (sut, authService, _) = makeSUT()
        setBaseInputs(to: sut, password: password, confirmPassword: password)
        
        #expect(sut.isSignInDisabled == false)
        await sut.createAccountAction()
        let errorDescription = try #require(validationError.errorDescription)
        
        #expect(sut.passwordError == errorDescription)
        #expect(authService.registerCallCount == 0)
    }
    
    @Test
    func signUpWithMismatchedPasswords() async throws {
        let (sut, authService, _) = makeSUT()
        setBaseInputs(to: sut, confirmPassword: "Different123")
        
        #expect(sut.isSignInDisabled == false)
        await sut.createAccountAction()
        let errorDescription = try #require(ValidationError.passwordsNotMatch.errorDescription)
        
        #expect(sut.confirmPasswordError == errorDescription)
        #expect(authService.registerCallCount == 0)
    }
    
    @Test
    func signUpFail() async throws {
        let (sut, _, _) = makeSUT(shouldThrowError: true)
        setBaseInputs(to: sut)
        
        #expect(sut.isSignInDisabled == false)
        await sut.createAccountAction()
        
        let error = try #require(sut.error as? TestError)
        #expect(error == .expectedFailure)
    }
    
    @Test
    func stopLoadingAfterFailedSignUp() async {
        let (sut, _, _) = makeSUT(shouldThrowError: true)
        setBaseInputs(to: sut)
        
        #expect(sut.isSignInDisabled == false)
        await sut.createAccountAction()
        
        #expect(sut.isLoading == false)
    }
    
    @Test
    func stopLoadingAfterSucceededSignUp() async {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut)
        
        #expect(sut.isSignInDisabled == false)
        await sut.createAccountAction()
        
        #expect(sut.isLoading == false)
    }
    
    @Test
    func successSignUp() async {
        let (sut, authService, _) = makeSUT()
        setBaseInputs(to: sut)
        
        #expect(sut.isSignInDisabled == false)
        await sut.createAccountAction()
        
        #expect(sut.error == nil)
        #expect(sut.emailError.isEmpty)
        #expect(sut.passwordError.isEmpty)
        #expect(sut.confirmPasswordError.isEmpty)
        #expect(sut.isLoading == false)
        #expect(authService.isAuthenticated)
        #expect(authService.registerCallCount == 1)
        #expect(authService.receivedEmail == sut.email)
        #expect(authService.receivedPassword == sut.password)
    }
    
    @Test
    func clearErrorAfterTypingEmail() async {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut, email: "as")
        
        #expect(sut.isSignInDisabled == false)
        await sut.createAccountAction()
        
        sut.email = "a"
        #expect(sut.emailError.isEmpty)
    }
    
    @Test
    func clearErrorAfterTypingPassword() async {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut, password: "as", confirmPassword: "as")
        
        #expect(sut.isSignInDisabled == false)
        await sut.createAccountAction()
        
        sut.password = "a"
        #expect(sut.passwordError.isEmpty)
    }
    
    @Test
    func clearErrorAfterTypingConfirmPassword() async {
        let (sut, _, _) = makeSUT()
        setBaseInputs(to: sut, confirmPassword: "Different123")
        
        #expect(sut.isSignInDisabled == false)
        await sut.createAccountAction()
        
        sut.confirmPassword = "a"
        #expect(sut.confirmPasswordError.isEmpty)
    }
    
    @Test
    func navigateToSignIn() {
        let (sut, _, navigationHandler) = makeSUT()
        navigationHandler.path = [.signUp]
        
        sut.signInAction()
        
        #expect(navigationHandler.path.isEmpty)
    }
    
    @discardableResult
    func setBaseInputs(
        to sut: SignUpViewModel,
        fullName: String = "Alex Smith",
        email: String = "abc@gmail.com",
        password: String = "Abcd1234",
        confirmPassword: String = "Abcd1234"
    ) -> (fullName: String, email: String, password: String, confirmPassword: String) {
        sut.fullName = fullName
        sut.email = email
        sut.password = password
        sut.confirmPassword = confirmPassword
        return (sut.fullName, sut.email, sut.password, sut.confirmPassword)
    }
    
    func makeSUT(isLoggedIn: Bool = false, shouldThrowError: Bool = false) -> (
        SignUpViewModel,
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
