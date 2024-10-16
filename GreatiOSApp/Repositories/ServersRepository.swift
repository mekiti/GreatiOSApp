import Foundation

protocol ServersRepository {
    func fetchServers() async throws -> [Server]
}

class ServerRepositoryImpl: ServersRepository {
    let apiManager: APIManager

    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }

    func fetchServers() async throws -> [Server] {
        let servers: [Server] = try await apiManager.get(urlString: URLs.serversURL)
        return servers
    }
}
