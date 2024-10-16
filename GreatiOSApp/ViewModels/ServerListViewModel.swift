import SwiftUI
import Observation

struct ServerListViewModel {
    private let keychainWrapper: KeychainWrapper
    private let tokenManager: TokenManager
    let servers: [Server]
    var showingAlert = false
    var sort = SortBy.none

    @MainActor
    init(
        keychainWrapper: KeychainWrapper = KeychainWrapper(),
        tokenManager: TokenManager = TokenManager.shared,
        servers: [Server]
    ) {
        self.keychainWrapper = keychainWrapper
        self.tokenManager = tokenManager
        self.servers = servers
    }

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
        tokenManager.clear()
        if let username = UserDefaults.standard.string(forKey: Constants.usernameKey) {
            keychainWrapper.delete(key: username)
        }
    }
}

