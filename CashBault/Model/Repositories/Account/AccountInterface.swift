//
//  AccountInterface.swift
//  CashBault
//
//  Created by manueltirado on 16/5/24.
//

import Foundation

struct AccountInterface {
    
    static func getUserAccounts(userId: Int) async throws -> [Account] {
        try await AccountRepository.getUserAccounts(userId: userId)
    }
    
    static func getCurrencies() async throws -> [AccountCurrencyDTO] {
        try await AccountRepository.getCurrencies()
    }
    
    static func createAccount() async throws {
        try await AccountRepository.createAccount()
    }
}
