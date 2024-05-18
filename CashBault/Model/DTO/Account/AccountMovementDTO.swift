//
//  AccountMovementDTO.swift
//  CashBault
//
//  Created by manueltirado on 16/5/24.
//

import Foundation

// MARK: - DTO
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

// MARK: - MOCKS
extension AccountMovement {
    static var EmptyArray: [AccountMovement] {
        return [
            .init(id: 1, state: .done, date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), concept: "Aaaaaaa aaaaaaaa", currency: "", currencySymbol: "", quantity: -1, sender: "Aaaaaa Aaaaaa"),
            .init(id: 2, state: .pending, date: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), concept: "Aaaa aaaaaaaa", currency: "", currencySymbol: "", quantity: -1, sender: "Aaaaaa Aaaaaaa"),
            .init(id: 3, state: .pending, date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), concept: "Aa aaaaaaaa", currency: "", currencySymbol: "", quantity: -1, sender: "Aaa Aaaa"),
            .init(id: 4, state: .done, date: Date(), concept: "Aaaaaa", currency: "", currencySymbol: "", quantity: -1, sender: "Aaaaaaa Aaaaaa"),
            .init(id: 5, state: .pending, date: Date(), concept: "Aaaa", currency: "", currencySymbol: "", quantity: -1, sender: "Aaaaaa Aaaaaaaaa"),
        ]
    }
    
    static var Mock1: AccountMovement {
        .init(id: 1, state: .pending, date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), concept: "Pending Movement", currency: "EUR", currencySymbol: "€", quantity: 100, sender: "Bijoy Anticlea Hanne")
    }
    static var Mock2: AccountMovement {
        .init(id: 2, state: .done, date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), concept: "Done Movement", currency: "EUR", currencySymbol: "€", quantity: 200, sender: "Melanija Lúcia Dileep")
    }
    static var Mock3: AccountMovement {
        .init(id: 3, state: .cancelled, date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), concept: "Cancelled Movement", currency: "EUR", currencySymbol: "€", quantity: 10000000000000000, sender: "Ace Azaria Olindo")
    }
    static var Mock4: AccountMovement {
        .init(id: 4, state: .cancelled, date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), concept: "Cancelled Movement", currency: "EUR", currencySymbol: "€", quantity: 300, sender: "Ace Azaria Olindo")
    }
    static var Mock5: AccountMovement {
        .init(id: 5, state: .pending, date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), concept: "Negative Movement Pending", currency: "EUR", currencySymbol: "€", quantity: -10, sender: "Ace Azaria Olindo")
    }
    static var Mock6: AccountMovement {
        .init(id: 6, state: .done, date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), concept: "Negative Movement Done", currency: "EUR", currencySymbol: "€", quantity: -300, sender: "Ace Azaria Olindo")
    }
    static var Mock7: AccountMovement {
        .init(id: 7, state: .cancelled, date: Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date(), concept: "Negative Movement Canelled", currency: "EUR", currencySymbol: "€", quantity: -30000, sender: "Ace Azaria Olindo")
    }
}
