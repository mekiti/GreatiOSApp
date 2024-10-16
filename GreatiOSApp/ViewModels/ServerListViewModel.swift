import SwiftUI
import Observation

struct ServerListViewModel {
    let servers: [Server]
    var showingAlert = false
    var sort = SortBy.none

    var sortedServers: [Server] {
        switch sort {
        case .name:
            return servers.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .distance:
            return servers.sorted { $0.distance < $1.distance }
        case .none:
            return servers
        }
    }
}

