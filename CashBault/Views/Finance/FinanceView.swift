//
//  FinanceView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct FinanceView: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var accountsModel: AccountsModel
    @State private var navigateToAddAccount: Bool = false
    var isLoading: Bool {
        accountsModel.loadingAccounts
    }
    var groupedAccounts: [(String, [Account])] {
        Dictionary(grouping: accountsModel.accounts ?? []) { account in
            account.currencySymbol
        }.sorted { $0.key > $1.key }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                totalBalances
                accountsBalances
                Spacer(minLength: 0)
            }
            .animation(.easeIn(duration: 0.2), value: isLoading)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Constants.backgroundColorGradient)
            .background(navigation)
            .customNavigationBar(
                customCenterContent: {
                    Text(L10n.tabFinanceTitle)
                        .modifier(TextModifier(size: 16, weight: .bold, color: .white))
                }
            )
        }
    }
    
    @ViewBuilder
    var totalBalances: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                if !accountsModel.loadingAccounts && accountsModel.accounts?.isEmpty ?? true {
                    Text(L10n.financeTotalBalanceNoBalanceLabel)
                        .modifier(TextModifier(size: 18, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                } else {
                    Text(L10n.financeTotalBalanceLabel)
                        .modifier(TextModifier(size: 18, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                    if !isLoading {
                        ForEach(groupedAccounts, id: \.0) { currency, account in
                            Text("\(Util.getTwoDigitStr(num: getAccountsBalance(account))) \(currency)")
                                .modifier(TextModifier(size: 32, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                        }
                    } else {
                        Text("AAAA A")
                            .modifier(TextModifier(size: 32, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                    }
                }
            }
            Spacer(minLength: 0)
        }
        .modifier(LoadingShimmeringModifierV2(isLoading: $accountsModel.loadingAccounts))

    }
    
    @ViewBuilder
    var accountsBalances: some View {
        if !accountsModel.loadingAccounts && accountsModel.accounts?.isEmpty ?? true {
            Text(L10n.financeNoAccountLabel)
            .modifier(TextModifier(size: 18, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
        } else {
            ScrollView {
                LazyVStack {
                    VStack {
                        Text(L10n.financeNormalAccountsTitle)
                            .modifier(TextModifier(size: 16, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        if isLoading {
                            FinanceAccountCellView(account: Account.Empty)
                        } else if let accounts = accountsModel.accounts {
                            ForEach(accounts.filter({ $0.type == .normal }), id: \.id) { account in
                                FinanceAccountCellView(account: account)
                            }
                            Text(L10n.financeSavingAccountsTitle)
                                .modifier(TextModifier(size: 16, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ForEach(accounts.filter({ $0.type == .saving }), id: \.id) { account in
                                FinanceAccountCellView(account: account)
                            }
                        }
                    }
                    if !isLoading {
                        AppButtonView(text: "+ \(L10n.financeAddAccountLabel)") {
                            navigateToAddAccount = true
                        }
                        .padding(.vertical, 16)
                    }
                }
            }
            .scrollDisabled(isLoading ? true : false)
            .modifier(LoadingShimmeringModifier(isLoading: $accountsModel.loadingAccounts))
        }
    }
    
    @ViewBuilder
    var navigation: some View {
        EmptyView()
            .navigationDestination(isPresented: $navigateToAddAccount) {
                FinanceAddAccountView()
            }
    }
}

extension FinanceView {
    private func getAccountsBalance(_ accounts: [Account]) -> Double {
        var balance: Double = 0
        accounts.forEach({ balance += $0.balance })
        return balance
    }
}

#Preview {
    FinanceView()
        .environmentObject(AppState())
        .environmentObject(AccountsModel.Mock)
}
