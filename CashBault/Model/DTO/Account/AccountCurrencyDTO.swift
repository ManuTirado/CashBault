//
//  AccountCurrencyDTO.swift
//  CashBault
//
//  Created by manueltirado on 18/5/24.
//

import Foundation

// MARK: - DTO
struct AccountCurrencyDTO {
    var id: Int
    var name: String
    var symbol: String
}

// MARK: - EXTENDS
extension AccountCurrencyDTO: Hashable {
    static func == (lhs: AccountCurrencyDTO, rhs: AccountCurrencyDTO) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - MOCKS
extension AccountCurrencyDTO {
    static var Mock1: AccountCurrencyDTO {
        return .init(id: 1, name: "EUR", symbol: "€")
    }
    static var Mock2: AccountCurrencyDTO {
        return .init(id: 2, name: "GBP", symbol: "£")
    }
    static var Mock3: AccountCurrencyDTO {
        return .init(id: 3, name: "USD", symbol: "$")
    }
    static var Mock4: AccountCurrencyDTO {
        return .init(id: 4, name: "HUF", symbol: "ƒ")
    }
}
