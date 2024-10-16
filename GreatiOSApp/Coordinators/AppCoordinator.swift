import SwiftUI

@MainActor
@Observable
class AppCoordinator: @preconcurrency Coordinator {
    private var authRepo = AuthRepositoryImpl()
    var navigationPath = NavigationPath()

    func start() -> some View {
        LoginView(viewModel: LoginViewModel(authService: AuthService(repository: authRepo), coordinator: self))
    }

    func buildServer() -> some View {
        ServerListView(
            viewModel: ServerListViewModel(
                serversService: ServersService(
                    repository: ServerRepositoryImpl()
                )
            )
        )
    }

    func showServers() {
        navigationPath.append(AppDestination.servers)
    }
}

enum AppDestination {
    case servers
}
