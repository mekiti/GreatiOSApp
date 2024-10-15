import Foundation

protocol AuthRepository {
    func login(credentials: LoginCredentials) async throws -> LoginResponse
}

class AuthRepositoryImpl: AuthRepository {
    private let tokenURL = URL(string: URLs.tokenURL)!

    func login(credentials: LoginCredentials) async throws -> LoginResponse {
        let credentials = LoginCredentials(username: credentials.username, password: credentials.password)

        guard let jsonData = try? JSONEncoder().encode(credentials) else {
            throw NetworkError.encodingError("Error encoding login credentials")
        }

        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw NetworkError.response("Login failed with status code \(httpResponse.statusCode)")
        }

        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)

        return loginResponse
    }
}
