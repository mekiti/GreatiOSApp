import Foundation

class MockCoordinator: AppCoordinator {
    var showServersCalled = false

    override func showServers() {
        showServersCalled = true
    }
}
