protocol ServersServiceProtocol {
    func execute(token: String) async throws -> [Server]
}

class ServersService: ServersServiceProtocol {
    private let repository: ServersRepository

    init(repository: ServersRepository) {
        self.repository = repository
    }

    func execute(token: String) async throws -> [Server] {
        try await repository.fetchServers(token: token)
    }
}
