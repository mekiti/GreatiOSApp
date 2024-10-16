import SwiftUI
import SwiftData

@main
struct GreatiOSAppApp: App {
    @State private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
        .modelContainer(for: [Server.self], isAutosaveEnabled: false)
    }
}
