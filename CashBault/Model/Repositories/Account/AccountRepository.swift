//
//  AccountRepository.swift
//  CashBault
//
//  Created by manueltirado on 16/5/24.
//

import Foundation

struct AccountRepository {
        
    static func getUserAccounts(userId: Int) async throws -> [Account] {
        try await Task.sleep(nanoseconds: 5_000_000_000)
        return [Account.Mock1, Account.Mock2, Account.Mock3]
    }
}
