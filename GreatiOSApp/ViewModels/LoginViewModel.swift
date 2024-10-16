import SwiftUI
import Observation
import SwiftData

@Observable
class LoginViewModel: @unchecked Sendable {
    private let keychainWrapper: KeychainWrapper
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

    init(
        authService: AuthServiceProtocol,
        serversService: ServersServiceProtocol,
        coordinator: AppCoordinator,
        keychainWrapper: KeychainWrapper = KeychainWrapper()
    ) {
        self.authService = authService
        self.serversService = serversService
        self.coordinator = coordinator
        self.keychainWrapper = keychainWrapper
    }

    func checkIfUserSaved() async {
        if let usernameKey = UserDefaults.standard.string(forKey: Constants.usernameKey) {
            await performLoginIfUserSaved(user: usernameKey)
        }
    }

    func performLoginIfUserSaved(user: String) async {
        if let loginCredentials = await keychainWrapper.get(key: user) {
            username = loginCredentials.username
            password = loginCredentials.password

            await initiateLogin()
        }
    }

    func initiateLogin() async {
        isLoading = true
        do {
            try await login()
            try await fetchServers()
            isLoading = false
            await showServers()
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

