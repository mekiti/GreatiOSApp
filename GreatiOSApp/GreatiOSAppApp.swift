//
//  GreatiOSAppApp.swift
//  GreatiOSApp
//
//  Created by Domas Zaboras on 15/10/2024.
//

import SwiftUI

@main
struct GreatiOSAppApp: App {
    @State private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
