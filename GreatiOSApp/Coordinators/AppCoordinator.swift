import SwiftUI

@MainActor
@Observable
class AppCoordinator: @preconcurrency Coordinator {
    private let apiManager = APIManager()
    var navigationPath = NavigationPath()

    func start() -> some View {
        LoginView(
            viewModel: LoginViewModel(
                authService: AuthService(repository: AuthRepositoryImpl(apiManager: apiManager)),
                serversService: ServersService(repository: ServerRepositoryImpl(apiManager: apiManager)),
                coordinator: self
            )
        )
    }

    func buildServer(servers: [Server]) -> some View {
        ServerListView(viewModel: ServerListViewModel(servers: servers))
    }

    func showServers() {
        navigationPath.append(AppDestination.servers)
    }
}

enum AppDestination {
    case servers
}
