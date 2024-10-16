import SwiftUI
import Observation

@Observable
class LoginViewModel: @unchecked Sendable {
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

        let loginCredentials = try await authService.execute(
            credentials: LoginCredentials(
                username: username,
                password: password
            )
        )

        await saveToken(loginCredentials.token)
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

