//
//  Scale_LibraryApp.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import SwiftUI

@main
struct Scale_LibraryApp: App {
    
    @StateObject var launchScreenManager = LaunchScreenManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                /// Observes state of launch screen and renders it accordingly
                if launchScreenManager.state != .completed {
                    LaunchScreenView()
                }
            }
            .environmentObject(launchScreenManager)
        }
    }
}
