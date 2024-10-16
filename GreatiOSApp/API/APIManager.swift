import Foundation

class APIManager {
    private let session = URLSession.shared
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    func get<T: Decodable>(urlString: String) async throws -> T {
        guard let token = await TokenManager.shared.getToken() else {
            throw NetworkError.noToken
        }

        guard let URL = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        let request = setupRequest(url: URL, method: .GET, token: token)

        let (data, response) = try await session.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.response("GET request failed with status code \(httpResponse.statusCode)")
        }

        let decodedData = try decoder.decode(T.self, from: data)

        return decodedData
    }

    func post<T: Decodable>(urlString: String, parameters: Encodable) async throws -> T {
        guard let URL = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        guard let jsonData = try? encoder.encode(parameters) else {
            throw NetworkError.encodingError("Error encoding parameters")
        }

        let request = setupRequest(url: URL, method: .POST, body: jsonData)

        let (data, response) = try await session.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw NetworkError.response("POST request failed with status code \(httpResponse.statusCode)")
        }

        let decodedData = try decoder.decode(T.self, from: data)

        return decodedData
    }

    private func setupRequest(url: URL, method: Method, token: String? = nil, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body {
            request.httpBody = body
        }

        return request
    }
}
