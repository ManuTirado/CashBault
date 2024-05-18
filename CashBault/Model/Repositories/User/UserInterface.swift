//
//  UserInterface.swift
//  CashBault
//
//  Created by manueltirado on 16/5/24.
//

import Foundation

struct UserInterface {
    
    static func doLogin(user: String, password: String) async throws -> User {
        try await UserRepository.doLogin(user: user, password: password)
    }
    
    static func doBiometricLogin(user: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: 100_000_000)
        return User.Mock
    }
}
