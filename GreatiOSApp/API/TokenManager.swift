import Foundation

@MainActor
final class TokenManager {
    static let shared = TokenManager()

    private var token: String? = nil

    func getToken() -> String? {
        token
    }

    func update(token: String) {
        self.token = token
    }

    func clear() {
        token = nil
    }
}
