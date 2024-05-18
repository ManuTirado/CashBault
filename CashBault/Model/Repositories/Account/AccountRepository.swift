//
//  AccountRepository.swift
//  CashBault
//
//  Created by manueltirado on 16/5/24.
//

import Foundation

struct AccountRepository {
        
    static func getUserAccounts(userId: Int) async throws -> [Account] {
        try await Task.sleep(nanoseconds: 3_500_000)
        return [.Mock1, .Mock2, .Mock3]
    }
    
    static func getCurrencies() async throws -> [AccountCurrencyDTO] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return [.Mock1, .Mock2, .Mock3, .Mock4]
    }
    
    static func createAccount() async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
    }
}
