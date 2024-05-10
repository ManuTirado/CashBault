//
//  ContentView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var appState = AppState()
    
    var body: some View {
        ZStack {
            Constants.backgroundColorGradient
                .ignoresSafeArea()
            
            if appState.user != nil {
                AppTabView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .trailing))
            } else {
                LoginView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.spring, value: appState.user != nil)
        .environmentObject(appState)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
