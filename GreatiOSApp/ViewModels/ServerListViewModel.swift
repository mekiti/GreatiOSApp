import SwiftUI
import Observation

struct ServerListViewModel {
    private let keychainWrapper = KeychainWrapper()
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

    @MainActor
    func logoutAction() {
        TokenManager.shared.clear()
        if let username = UserDefaults.standard.string(forKey: Constants.usernameKey) {
            keychainWrapper.delete(key: username)
        }
    }
}

