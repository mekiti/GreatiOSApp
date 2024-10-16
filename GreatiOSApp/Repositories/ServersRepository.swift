import Foundation

protocol ServersRepository {
    func fetchServers(token: String) async throws -> [Server]
}

class ServerRepositoryImpl: ServersRepository {
    func fetchServers(token: String) async throws -> [Server] {
        let serversURL = URL(string: URLs.serversURL)!

        var request = URLRequest(url: serversURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.response("Server fetch failed with status code \(httpResponse.statusCode)")
        }

        let servers = try JSONDecoder().decode([Server].self, from: data)

        return servers
    }
}
