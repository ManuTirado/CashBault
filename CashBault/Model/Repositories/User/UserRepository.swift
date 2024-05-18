//
//  UserRepository.swift
//  CashBault
//
//  Created by manueltirado on 16/5/24.
//

import Foundation

struct UserRepository {
    
    static func doLogin(user: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: 2_500_000_000)
        if user == "test@test.com" && password == "A1234567" {
            try await Task.sleep(nanoseconds: 2_500_000_000)
            return .Mock
        } else {
            throw AppError.custom(L10n.loginNotFoundError)
        }
    }
}
