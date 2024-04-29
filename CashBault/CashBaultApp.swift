//
//  CashBaultApp.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

@main
struct CashBaultApp: App {
    
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
