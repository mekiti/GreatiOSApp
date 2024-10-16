protocol AuthServiceProtocol {
    func execute(credentials: LoginCredentials) async throws -> LoginResponse
}

class AuthService: AuthServiceProtocol {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(credentials: LoginCredentials) async throws -> LoginResponse {
        try await repository.login(credentials: credentials)
    }
}
