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

struct Account: Hashable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum AccountType {
        case normal
        case saving
        
        var title: String {
            switch self {
            case .normal:
                L10n.accountTypeNormalTitle
            case .saving:
                L10n.accountTypeSavingTitle
            }
        }
    }
    
    var id: Int
    var iban: String
    var type: AccountType
    var name: String
    var currency: String
    var currencySymbol: String
    var balance: Double
    var movements: [AccountMovement]
}

struct AccountMovement {
    
    enum MovementState {
        case pending
        case cancelled
        case done
    }
    
    var id: Int
    var state: MovementState
    var date: Date
    var concept: String
    var currency: String
    var currencySymbol: String
    var quantity: Double
    var sender: String
}

extension Account {
    static var Mock1: Account {
        .init(id: 1, iban: "NL24ABNA6971032004", type: .normal, name: "Main Account", currency: "EUR", currencySymbol: "€", balance: 1000, movements: [AccountMovement.Mock1,
                                                                                                                                  AccountMovement.Mock2,
                                                                                                                                  AccountMovement.Mock3,
                                                                                                                                  AccountMovement.Mock4,
                                                                                                                                  AccountMovement.Mock5,
                                                                                                                                  AccountMovement.Mock6,
                                                                                                                                  AccountMovement.Mock7])
    }
    static var Mock2: Account {
        .init(id: 2, iban: "NL63RABO3665292913", type: .saving, name: "Saving Account", currency: "EUR", currencySymbol: "€", balance: 2000, movements: [AccountMovement.Mock1,
                                                                                                                                  AccountMovement.Mock2,
                                                                                                                                  AccountMovement.Mock3,
                                                                                                                                  AccountMovement.Mock4])
    }
}

extension AccountMovement {
    static var Mock1: AccountMovement {
        .init(id: 1, state: .pending, date: Date(), concept: "Pending Movement", currency: "EUR", currencySymbol: "€", quantity: 100, sender: "Bijoy Anticlea Hanne")
    }
    static var Mock2: AccountMovement {
        .init(id: 2, state: .done, date: Date(), concept: "Done Movement", currency: "EUR", currencySymbol: "€", quantity: 200, sender: "Melanija Lúcia Dileep")
    }
    static var Mock3: AccountMovement {
        .init(id: 3, state: .cancelled, date: Date(), concept: "Cancelled Movement", currency: "EUR", currencySymbol: "€", quantity: 10000000000000000, sender: "Ace Azaria Olindo")
    }
    static var Mock4: AccountMovement {
        .init(id: 4, state: .cancelled, date: Date(), concept: "Cancelled Movement", currency: "EUR", currencySymbol: "€", quantity: 300, sender: "Ace Azaria Olindo")
    }
    static var Mock5: AccountMovement {
        .init(id: 5, state: .pending, date: Date(), concept: "Negative Movement Pending", currency: "EUR", currencySymbol: "€", quantity: -10, sender: "Ace Azaria Olindo")
    }
    static var Mock6: AccountMovement {
        .init(id: 6, state: .done, date: Date(), concept: "Negative Movement Done", currency: "EUR", currencySymbol: "€", quantity: -300, sender: "Ace Azaria Olindo")
    }
    static var Mock7: AccountMovement {
        .init(id: 7, state: .cancelled, date: Date(), concept: "Negative Movement Canelled", currency: "EUR", currencySymbol: "€", quantity: -30000, sender: "Ace Azaria Olindo")
    }
}

extension AccountsModel {
    static var Mock: AccountsModel {
        let model = AccountsModel()
        model.accounts = [Account.Mock1, Account.Mock2]
        model.selectedAccount = model.accounts?.first
        return model
    }
}
