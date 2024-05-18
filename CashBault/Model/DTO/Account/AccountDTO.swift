//
//  AccountDTO.swift
//  CashBault
//
//  Created by manueltirado on 16/5/24.
//

import Foundation

// MARK: - DTO
struct Account {
    var id: Int
    var iban: String
    var type: AccountType
    var name: String
    var currency: String
    var currencySymbol: String
    var balance: Double
    var movements: [AccountMovement]
    
    enum AccountType {
        case normal
        case saving
    }
}

// MARK: - EXTENDS
extension Account: Hashable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - MOCKS
extension Account {
    static var Empty: Account {
        .init(id: 0, iban: "", type: .normal, name: "", currency: "", currencySymbol: "", balance: 0, movements: [])
    }
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
    static var Mock3: Account {
        .init(id: 3, iban: "PL63RABO1665251951", type: .normal, name: "Foreign Account", currency: "GBP", currencySymbol: "£", balance: 563.22, movements: [])
    }
}
