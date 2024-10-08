//
//  autoCheckApp.swift
//  autoCheck
//
//  Created by 방성환 on 2023/09/21.
//

import SwiftUI

@main
struct autoCheckApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(ConnectBeacon())
        }
    }
}
