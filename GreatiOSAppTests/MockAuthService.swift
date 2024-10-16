import Foundation

class MockAuthService: AuthServiceProtocol {
    var mockLoginResponse: LoginResponse?
    var shouldThrowError = false
    var loginCalled = false

    func execute(credentials: LoginCredentials) async throws -> LoginResponse {
        loginCalled = true
        if shouldThrowError {
            throw NetworkError.noCredentials
        }
        return mockLoginResponse ?? LoginResponse(token: "Token123")
    }
}
