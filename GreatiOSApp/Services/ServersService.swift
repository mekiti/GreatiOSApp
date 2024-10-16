protocol ServersServiceProtocol {
    func execute() async throws -> [Server]
}

class ServersService: ServersServiceProtocol {
    private let repository: ServersRepository

    init(repository: ServersRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Server] {
        try await repository.fetchServers()
    }
}
