import Foundation

protocol AuthRepository {
    func login(credentials: LoginCredentials) async throws -> LoginResponse
}

class AuthRepositoryImpl: AuthRepository {
    let apiManager: APIManager

    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }

    func login(credentials: LoginCredentials) async throws -> LoginResponse {
        let credentials = LoginCredentials(username: credentials.username, password: credentials.password)

        let loginResponse: LoginResponse = try await apiManager.post(
            urlString: URLs.tokenURL,
            parameters: credentials
        )

        return loginResponse
    }
}
