//
//  AppTabView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct AppTabView: View {
    
    @StateObject var accountsModel = AccountsModel()
    @State private var selectedTab: Int = Tabs.homepage.id
    
    enum Tabs: Identifiable, CaseIterable {
        case homepage
        case finance
        case explore
        case cards
        
        var id: Int {
            switch self {
            case .homepage:
                return 0
            case .finance:
                return 1
            case .explore:
                return 2
            case .cards:
                return 3
            }
        }
        var title: String {
            switch self {
            case .homepage:
                return L10n.tabHomeTitle
            case .finance:
                return L10n.tabFinanceTitle
            case .explore:
                return L10n.tabExploreTitle
            case .cards:
                return L10n.tabCardsTitle
            }
        }
        var icon: Image {
            switch self {
            case .homepage:
                return Image(systemName: "house")
            case .finance:
                return Image(systemName: "chart.bar")
            case .explore:
                return Image(systemName: "sparkles.rectangle.stack")
            case .cards:
                return Image(systemName: "creditcard")
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(Tabs.homepage.id)
                FinanceView()
                    .tag(Tabs.finance.id)
                ExploreView()
                    .tag(Tabs.explore.id)
                CardsView()
                    .tag(Tabs.cards.id)
            }
            ZStack {
                HStack(spacing: 0) {
                    ForEach(Tabs.allCases, id: \.id) { tab in
                        Button {
                            self.selectedTab = tab.id
                        } label: {
                            AppTabItemView(selectedTab: $selectedTab, tabItem: tab)
                        }
                        .disabled(selectedTab == tab.id ? true : false)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.indigo)
        }
        .environmentObject(accountsModel)
    }
}

extension AppTabView {
    
    struct AppTabItemView: View {
        
        @Binding var selectedTab: Int
        let tabItem: Tabs
        
        private var isSelected: Bool {
            selectedTab == tabItem.id
        }
        
        var body: some View {
            ZStack {
                Text(tabItem.title)
                    .padding(.top, 50)
                tabItem.icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: isSelected ? 35 : 25)
                    .offset(y: isSelected ? -15 : 0)
            }
            .frame(height: 50)
            .foregroundStyle(isSelected ? Color.green : Color.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical, 16)
            .background(
                Capsule()
                    .fill(.indigo)
                    .offset(y: isSelected ? 0 : 16)
            )
            .animation(.bouncy, value: isSelected)
        }
    }
}

#Preview {
    AppTabView()
        .environmentObject(AppState())
}
