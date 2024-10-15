import SwiftUI

class ServerListViewModel: ObservableObject {
    @Published var servers: [Server] = []
    private let serversService: ServersService

    init(serversService: ServersService) {
        self.serversService = serversService
        loadServers()
    }

    func loadServers() {
        servers = serversService.execute()
    }
}

