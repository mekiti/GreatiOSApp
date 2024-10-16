import SwiftUI
import Observation

@Observable
class LoginViewModel: @unchecked Sendable {
    private let keychainWrapper = KeychainWrapper()
    private let authService: AuthServiceProtocol
    private let serversService: ServersServiceProtocol
    private var alertTitle: String?
    private var alertMessage: String?

    var coordinator: AppCoordinator
    var isLoading: Bool = false
    var username: String = ""
    var password: String = ""
    var showingAlert: Bool = false
    var servers: [Server] = []

    var alertTitleString: String {
        alertTitle ?? Constants.unexpectedAlertTitle
    }

    var alertMessageString: String {
        alertMessage ?? Constants.unexpectedAlertMessage
    }

    init(authService: AuthServiceProtocol, serversService: ServersServiceProtocol, coordinator: AppCoordinator) {
        self.authService = authService
        self.serversService = serversService
        self.coordinator = coordinator
    }

    func performLoginIfUserSaved() async {
        if let usernameKey = UserDefaults.standard.string(forKey: Constants.usernameKey),
           let loginCredentials = await keychainWrapper.get(key: usernameKey) {
            username = loginCredentials.username
            password = loginCredentials.password

            print("before initiateLogin")
            await initiateLogin()
        }
    }

    func initiateLogin() async {
        print("isLoading")
        isLoading = true
        do {
            print("inside do")
            try await login()
            print("after login")
            try await fetchServers()
            print("after fetchServers")
            isLoading = false
            print("before showServers")
            await showServers()
            print("after showServers")
        } catch NetworkError.noCredentials {
            alertTitle = Constants.noEntryAlertTitle
            alertMessage = Constants.noEntryAlertMessage
            showingAlert = true
            isLoading = false
        } catch {
            alertTitle = Constants.loginAlertTitle
            alertMessage = Constants.loginAlertMessage
            showingAlert = true
            isLoading = false
        }
    }

    func login() async throws {
        guard !username.isEmpty || !password.isEmpty else {
            throw NetworkError.noCredentials
        }

        let loginCredentials = LoginCredentials(username: username, password: password)
        let loginResponse = try await authService.execute(credentials: loginCredentials)

        keychainWrapper.save(loginCredentials: loginCredentials)

        await saveToken(loginResponse.token)
    }

    func fetchServers() async throws {
        servers = try await serversService.execute()
    }

    @MainActor
    func saveToken(_ token: String) {
        TokenManager.shared.update(token: token)
    }

    @MainActor
    func showServers() {
        coordinator.showServers()
    }
}

