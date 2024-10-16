import Foundation

class MockServersService: ServersServiceProtocol {
    var mockServers: [Server] = []
    var shouldThrowError = false

    func execute() async throws -> [Server] {
        if shouldThrowError {
            throw NetworkError.unavailable
        }
        return mockServers
    }
}
