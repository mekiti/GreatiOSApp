import SwiftUI
import Observation

@Observable
class ServerListViewModel {
    var servers: [Server] = []
    private let serversService: ServersService

    init(serversService: ServersService) {
        self.serversService = serversService
        loadServers()
    }

    func loadServers() {
        servers = serversService.execute()
    }
}

