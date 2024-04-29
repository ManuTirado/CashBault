//
//  AppTabView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct AppTabView: View {
    
    @State private var selectedTab: Tabs = .homepage
    
    enum Tabs {
        case homepage
        case finance
        case explore
        case cards
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView()
            }.tabItem {
                
            }
        }
    }
}

#Preview {
    AppTabView()
}
