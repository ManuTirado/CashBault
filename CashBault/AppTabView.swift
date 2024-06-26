//
//  AppTabView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct AppTabView: View {
    
    @EnvironmentObject var appState: AppState
    @StateObject var accountsModel = AccountsModel()
    @State private var selectedTab: Int = Tabs.homepage.id
    
    enum Tabs: Identifiable, CaseIterable {
        case homepage
        case finance
        case user
        
        var id: Int {
            switch self {
            case .homepage:
                return 0
            case .finance:
                return 1
            case .user:
                return 2
            }
        }
        var title: String {
            switch self {
            case .homepage:
                return L10n.tabHomeTitle
            case .finance:
                return L10n.tabFinanceTitle
            case .user:
                return L10n.tabUserTitle
            }
        }
        var icon: Image {
            switch self {
            case .homepage:
                return Image(systemName: "house")
            case .finance:
                return Image(systemName: "chart.bar")
            case .user:
                return Image(systemName: "person.crop.circle")
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(Tabs.homepage.id)
                    .environmentObject(accountsModel)
                FinanceView()
                    .tag(Tabs.finance.id)
                    .environmentObject(accountsModel)
                UserView()
                    .tag(Tabs.user.id)
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
            .background(Asset.Colors.background.swiftUIColor)
        }
        .onAppear {
            Task {
                await getUserAccounts()
            }
        }
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
            .foregroundStyle(isSelected ? Asset.Colors.primaryColor.swiftUIColor : Asset.Colors.secondaryColor.swiftUIColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical, 16)
            .background(
                Capsule()
                    .fill(Asset.Colors.background.swiftUIColor)
                    .offset(y: isSelected ? 0 : 16)
            )
            .animation(.bouncy, value: isSelected)
        }
    }
}

extension AppTabView {
    
    private func getUserAccounts() async {
        do {
            guard let user = appState.user else { return }
            accountsModel.errorGettingAccounts = false
            accountsModel.loadingAccounts = true
            accountsModel.accounts = try await AccountInterface.getUserAccounts(userId: user.id)
            accountsModel.selectedAccount = accountsModel.accounts?.first
        } catch {
            accountsModel.errorGettingAccounts = true
            print(error)
        }
        accountsModel.loadingAccounts = false
    }
}

#Preview {
    AppTabView()
        .environmentObject(AppState())
}
