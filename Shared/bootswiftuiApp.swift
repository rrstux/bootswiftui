//
//  bootswiftuiApp.swift
//  Shared
//
//  Created by Robert Sandru on 16.05.2021.
//

import SwiftUI

@main
struct bootswiftuiApp: App {
    
    @StateObject var appConfig: AppConfig = AppConfig()
    
    var body: some Scene {

        WindowGroup {
            ContentView()
                .environmentObject(appConfig)
                .overlay(appConfig.topViewUnwrapped)
        }
    }
}
