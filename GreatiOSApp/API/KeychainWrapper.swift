import Foundation
import Security
import SwiftUI

class KeychainWrapper {
    func save(loginCredentials: LoginCredentials) {
        guard UserDefaults.standard.string(forKey: Constants.usernameKey) == nil else {
            print("User already exists")
            return
        }

        let password = loginCredentials.password.data(using: .utf8)!

        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: loginCredentials.username,
            kSecValueData as String: password,
        ]

        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            UserDefaults.standard.set(loginCredentials.username, forKey: Constants.usernameKey)
            print("User saved successfully in the keychain")
        } else {
            print("Something went wrong trying to save the user in the keychain")
        }
    }

    func get(key: String) async -> LoginCredentials? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?

        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any],
               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                return LoginCredentials(username: username, password: password)
            }
        } else {
            print("Something went wrong trying to find the user in the keychain")
        }

        return nil
    }

    func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
        ]
        if SecItemDelete(query as CFDictionary) == noErr {
            UserDefaults.standard.set(nil, forKey: Constants.usernameKey)
            print("User removed successfully from the keychain")
        } else {
            print("Something went wrong trying to remove the user from the keychain")
        }
    }
}
