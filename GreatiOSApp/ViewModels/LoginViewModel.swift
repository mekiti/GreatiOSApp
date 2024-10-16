import SwiftUI
import Observation

@Observable
class LoginViewModel: @unchecked Sendable {
    private let authService: AuthServiceProtocol
    private var alertTitle: String?
    private var alertMessage: String?
    private var loginCredentials: LoginResponse?

    var coordinator: AppCoordinator
    var isLoading: Bool = false
    var username: String = ""
    var password: String = ""
    var showingAlert: Bool = false

    var alertTitleString: String {
        alertTitle ?? Constants.unexpectedAlertTitle
    }

    var alertMessageString: String {
        alertMessage ?? Constants.unexpectedAlertMessage
    }

    init(authService: AuthServiceProtocol, coordinator: AppCoordinator) {
        self.authService = authService
        self.coordinator = coordinator
    }

    func login() async {
        await didFinishLoading()

        return
        guard !username.isEmpty || !password.isEmpty else {
            alertTitle = Constants.noEntryAlertTitle
            alertMessage = Constants.noEntryAlertMessage
            showingAlert = true
            return
        }

        do {
            loginCredentials = try await authService.execute(
                credentials: LoginCredentials(
                    username: username,
                    password: password
                )
            )

            await didFinishLoading()
        } catch {
            alertTitle = Constants.loginAlertTitle
            alertMessage = Constants.loginAlertMessage
            showingAlert = true
        }
    }

    @MainActor
    func didFinishLoading() {
        coordinator.showServers()
    }
}

