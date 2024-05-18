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
    private var groupedMovements: [(Date, [AccountMovement])] {
        let movements = isLoading ? AccountMovement.EmptyArray : accountsModel.selectedAccount?.movements ?? []
        let groupedDictionary = Dictionary(grouping: movements) { object in
            Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: object.date) ?? Date()
        }
        return groupedDictionary.sorted {  $0.key.compare($1.key) == .orderedDescending }
    }
    private var isLoading: Bool {
        accountsModel.loadingAccounts
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                accountSelector
                accountActions
                movementsList
            }
            .animation(.easeIn(duration: 0.2), value: isLoading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Constants.backgroundColorGradient)
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
            } else {
                GeometryReader { reader in
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 10) {
                                ForEach(accountsModel.accounts ?? [Account.Empty], id: \.self) { account in
                                    AccountCellView(account: account, isLoading: $accountsModel.loadingAccounts)
                                        .frame(width: reader.size.width*0.9)
                                }
                            }
                            .padding(.horizontal)
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .scrollPosition(id: $accountsModel.selectedAccount)
                        .scrollIndicators(.never)
                        .scrollDisabled(isLoading ? true : false)
                }
                .frame(height: 150)
            }
        }
    }
    
    @ViewBuilder
    var accountActions: some View {
        VStack(spacing: 0) {
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
        }
    }
    
    @ViewBuilder
    var movementsList: some View {
        VStack(spacing: 0) {
            if accountsModel.selectedAccount?.movements.isEmpty ?? false && !isLoading {
                Text(L10n.noMovements)
                    .modifier(TextModifier(size: 18, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                    .padding(.top, 8)
                Spacer(minLength: 0)
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(groupedMovements, id: \.0) { day, movements in
                            VStack(alignment: .leading, spacing: 0) {
                                Text(Util.getFormattedDate(date: day, formatt: .weekName_day_monthName).uppercased())
                                    .modifier(TextModifier(size: 16, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                                    .padding(.vertical, 8)
                                LazyVStack(alignment: .leading, spacing: 0) {
                                    ForEach(movements, id: \.id) { movement in
                                        AccountMovementCellView(movement: movement)
                                            .modifier(TextModifier(size: 1, weight: .black))
                                        Rectangle()
                                            .fill(Asset.Colors.secondaryColor.swiftUIColor)
                                            .frame(height: 1)
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Asset.Colors.secondaryColor.swiftUIColor, lineWidth: 1)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 24)
                    .padding(.horizontal, 16)
                }
                .scrollDisabled(isLoading ? true : false)
                .modifier(LoadingShimmeringModifier(isLoading: $accountsModel.loadingAccounts))
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
