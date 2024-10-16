import Testing
import Foundation

struct LoginViewTests {
    private let testUser = "loginTestUser"
    private let testPassword = "loginTestPassword"
    private let keychainWrapper = MockKeychainWrapper()
    private let authService = MockAuthService()
    private let serversService = MockServersService()

    private func setupVM() async -> LoginViewModel {
        let coordinator = await MockCoordinator()

        return LoginViewModel(
            authService: authService,
            serversService: serversService,
            coordinator: coordinator,
            keychainWrapper: keychainWrapper
        )
    }

    @Test("Login with saved credentials") func testPerformLogin() async {
        let viewModel = await setupVM()

        // try to login without credentials
        await viewModel.performLoginIfUserSaved(user: "")

        #expect(viewModel.username == "")
        #expect(viewModel.password == "")
        #expect(!authService.loginCalled)

        // try to login with credentials
        keychainWrapper.credentials = LoginCredentials(username: testUser, password: testPassword)

        await viewModel.performLoginIfUserSaved(user: testUser)

        #expect(viewModel.username == testUser)
        #expect(viewModel.password == testPassword)
        #expect(authService.loginCalled)
    }

    @Test("Login without saved credentials") func testPerformLoginWithoutSavedCredentials() async {
        UserDefaults.standard.set(nil, forKey: testUser)
        let viewModel = await setupVM()


        // try to login without credentials
        await viewModel.initiateLogin()
        #expect(!authService.loginCalled)

        // try to login with credentials
        viewModel.username = testUser
        viewModel.password = testPassword
        await viewModel.initiateLogin()

        #expect(authService.loginCalled)
    }

    @Test("Test successful login") func testSuccessLogin() async {
        // Arrange
        serversService.mockServers = [Server(name: "TestServer", distance: 100)]

        let viewModel = await setupVM()
        viewModel.username = "testUser"
        viewModel.password = "testPass"

        // Act
        await viewModel.initiateLogin()

        // Assert
        #expect(viewModel.servers.count == 1)
        await #expect((viewModel.coordinator as? MockCoordinator)?.showServersCalled == true)
    }

}
