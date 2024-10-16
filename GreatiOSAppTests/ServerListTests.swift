//
//  ServerListTests.swift
//  GreatiOSAppTests
//
//  Created by Domas Zaboras on 16/10/2024.
//

import Testing
import Foundation

struct ServerListTests {
    private let testUser = Constants.usernameKey
    private let keychainWrapper = MockKeychainWrapper()
    private let testData = [
        Server(name: "Zeta", distance: 500),
        Server(name: "Alpha", distance: 200),
        Server(name: "Gamma", distance: 300)
    ]

    private func setupViewModel(data: [Server]) async -> ServerListViewModel {
        await ServerListViewModel(keychainWrapper: keychainWrapper, servers: data)
    }

    @Test("Servers sorted by name") func testSortedServersByName() async {
        var viewModel = await setupViewModel(data: testData)

        viewModel.sort = .name

        let sorted = viewModel.sortedServers

        #expect(sorted.map { $0.name } == ["Alpha", "Gamma", "Zeta"])
    }

    @Test("Servers sorted by distance") func testSortedServersByDistance() async {
        var viewModel = await setupViewModel(data: testData)
        viewModel.sort = .distance

        let sorted = viewModel.sortedServers

        #expect(sorted.map { $0.distance } == [200, 300, 500])
    }

    @Test("Logout") func testLogoutActionDeletesFromKeychain() async {
        UserDefaults.standard.set(testUser, forKey: testUser)
        let viewModel = await setupViewModel(data: [])

        await viewModel.logoutAction()

        #expect(keychainWrapper.deletedKey == testUser)
    }
}
