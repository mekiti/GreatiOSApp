import Foundation

class MockKeychainWrapper: KeychainWrapper {
    var credentials: LoginCredentials?
    var deletedKey: String?
    var saveCalled = false

    override func delete(key: String) {
        deletedKey = key
    }

    override func get(key: String) async -> LoginCredentials? {
        return credentials
    }

    override func save(loginCredentials: LoginCredentials) {
        saveCalled = true
        credentials = loginCredentials
    }
}
