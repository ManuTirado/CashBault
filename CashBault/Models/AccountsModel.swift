//
//  AccountsModel.swift
//  CashBault
//
//  Created by manueltirado on 30/4/24.
//

import Foundation

class AccountsModel: ObservableObject {
    
    @Published var accounts: Account?
    @Published var selectedAccount: Account?
}

struct Account {
    
    enum AccountType {
        case normal
        case saving
    }
    
    var id: Int
    var iban: String
    var type: AccountType
    var name: String
    var currency: String
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
    var quantity: Double
    var sender: String
}

extension Account {
    static var Mock1: Account {
        .init(id: 1, iban: "NL24ABNA6971032004", type: .normal, name: "Main Account", currency: "EUR", balance: 1000, movements: [AccountMovement.Mock1,
                                                                                                                                  AccountMovement.Mock2,
                                                                                                                                  AccountMovement.Mock3])
    }
    static var Mock2: Account {
        .init(id: 2, iban: "NL63RABO3665292913", type: .saving, name: "Saving Account", currency: "EUR", balance: 2000, movements: [AccountMovement.Mock1,
                                                                                                                                  AccountMovement.Mock2,
                                                                                                                                  AccountMovement.Mock3])
    }
}

extension AccountMovement {
    static var Mock1: AccountMovement {
        .init(id: 1, state: .pending, date: Date(), concept: "Pending Movement", currency: "EUR", quantity: 100, sender: "Bijoy Anticlea Hanne")
    }
    static var Mock2: AccountMovement {
        .init(id: 2, state: .done, date: Date(), concept: "Done Movement", currency: "EUR", quantity: 200, sender: "Melanija Lúcia Dileep")
    }
    static var Mock3: AccountMovement {
        .init(id: 3, state: .cancelled, date: Date(), concept: "Cancelled Movement", currency: "EUR", quantity: 300, sender: "Ace Azaria Olindo")
    }
}
