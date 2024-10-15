protocol ServersServiceProtocol {
    func execute() -> [Server]
}

class ServersService: ServersServiceProtocol {
    private let repository: ServersRepository

    init(repository: ServersRepository) {
        self.repository = repository
    }

    func execute() -> [Server] {
        return repository.getServers()
    }
}
