//
//  HomeView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct HomeView: View {
    
    enum AccountQuickActions: CaseIterable {
        case addMoney
        case sendMoney
        case scheduled
        case insights
        
        var icon: Image {
            switch self {
            case .addMoney:
                Image(systemName: "plus")
            case .sendMoney:
                Image(systemName: "arrow.forward")
            case .scheduled:
                Image(systemName: "calendar")
            case .insights:
                Image(systemName: "chart.pie")
            }
        }
        
        var iconForeground: Color {
            switch self {
            case .addMoney, .sendMoney:
                Asset.Colors.darkBackground.swiftUIColor
            case .scheduled, .insights:
                Asset.Colors.primaryColor.swiftUIColor
            }
        }
        
        var iconBackground: Color {
            switch self {
            case .addMoney, .sendMoney:
                Asset.Colors.accentColor.swiftUIColor
            case .scheduled, .insights:
                Color.clear
            }
        }
        
        var title: String {
            switch self {
            case .addMoney:
                L10n.homeActionAddMoney
            case .sendMoney:
                L10n.homeActionSendMoney
            case .scheduled:
                L10n.homeActionScheduled
            case .insights:
                L10n.homeActionInsights
            }
        }
        
        var textColor: Color {
            Asset.Colors.primaryColor.swiftUIColor
        }
    }
    
    @EnvironmentObject var accountsModel: AccountsModel
    @State private var accounts: [Account] = [Account.Mock1, Account.Mock2]
    @State private var selectedAccount: Account?
    @State private var selectedIndex: Int?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                accountSelector
                accountActions
                movementsList
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Asset.Colors.darkBackground.swiftUIColor)
            .customNavigationBar(
                customCenterContent: {
                    Text(L10n.tabHomeTitle)
                        .modifier(TextModifier(size: 16, weight: .bold, color: .white))
                }
            )
        }
    }
    
    @ViewBuilder
    var accountSelector: some View {
        VStack(spacing: 0) {
            if accountsModel.errorGettingAccounts {
                Text("ERROR")
                    .background(Color.red)
            } else if accountsModel.loadingAccounts {
                LoaderView()
            } else {
                GeometryReader { reader in
                    ScrollViewReader { value in
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 10) {
                                ForEach(accountsModel.accounts ?? [], id: \.self) { account in
                                    AccountCellView(account: account)
                                        .frame(width: reader.size.width*0.9)
                                }
                            }
                            .padding(.horizontal)
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.paging)
                        .scrollPosition(id: $accountsModel.selectedAccount)
                        .scrollIndicators(.never)
                    }
                }
                .frame(height: 150)
            }
        }
    }
    
    @ViewBuilder
    var accountActions: some View {
        VStack(spacing: 0) {
            if accountsModel.accounts != nil {
                HStack(spacing: 0) {
                    ForEach(AccountQuickActions.allCases, id: \.self) { item in
                        CircleIconButtonView(icon: item.icon,
                                             text: item.title,
                                             textColor: item.textColor,
                                             foregroundColor: item.iconForeground,
                                             backgroundColor: item.iconBackground) {
                            print("ITEM: \(item.title)")
                        }
                                             .frame(maxWidth: .infinity)
                    }
                }
            } else {
                Text("NO HAY CUENTAS")
                    .foregroundStyle(.white)
            }
        }
    }
    
    @ViewBuilder
    var movementsList: some View {
        VStack(spacing: 0) {
            if let selectedAccount = accountsModel.selectedAccount {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(selectedAccount.movements, id: \.id) { movement in
                            AccountMovementCellView(movement: movement)
                        }
                    }
                }
            } else {
                Text("NO HAY MOVIMIENTOS")
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(AppState())
    .environmentObject(AccountsModel.Mock)
}
