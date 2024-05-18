//
//  AccountsModel.swift
//  CashBault
//
//  Created by manueltirado on 30/4/24.
//

import Foundation

class AccountsModel: ObservableObject {
    
    @Published var accounts: [Account]?
    @Published var selectedAccount: Account?
    @Published var loadingAccounts: Bool = false
    @Published var errorGettingAccounts: Bool = false
}

extension AccountsModel {
    static var Mock: AccountsModel {
        let model = AccountsModel()
        model.accounts = [Account.Mock1, Account.Mock2, Account.Mock3]
//        model.accounts = []
        model.selectedAccount = model.accounts?.first
        return model
    }
}
