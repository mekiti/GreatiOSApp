import SwiftUI

@MainActor
@Observable
class AppCoordinator: @preconcurrency Coordinator {
    private var authRepo = AuthRepositoryImpl()
    private var serversRepo = ServerRepositoryImpl()
    var navigationPath = NavigationPath()

    func start() -> some View {
        LoginView(
            viewModel: LoginViewModel(
                authService: AuthService(repository: authRepo),
                serversService: ServersService(repository: serversRepo),
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
