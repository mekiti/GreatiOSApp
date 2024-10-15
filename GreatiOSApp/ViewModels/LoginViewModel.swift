import SwiftUI
import Observation

@Observable
class LoginViewModel {
    private let authService: AuthServiceProtocol
    private var alertTitle: String?
    private var alertMessage: String?
    private var loginCredentials: LoginResponse?

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

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func login() async {
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
        } catch {
            alertTitle = Constants.loginAlertTitle
            alertMessage = Constants.loginAlertMessage
            showingAlert = true
        }
    }
}

