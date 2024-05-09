//
//  AppState.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import Foundation

class AppState: ObservableObject {
    
    @Published var user: User?
}

extension AppState {
    
    func doLogin(email: String, password: String) async throws {
        if email == "test@test.com" && password == "A1234567" {
            try await Task.sleep(nanoseconds: 2_500_000_000)
            self.user = User.Mock
        } else {
            throw AppError.custom(L10n.loginNotFoundError)
        }
    }
    
    func doBiometricLogin() async throws {
        try await Task.sleep(nanoseconds: 500_000_000)
        self.user = User.Mock
    }
}

struct User: Equatable {
    var id: Int
    var fullName: String
    var birthDate: Date
    var email: String
    var phone: String
    var address: String
    var country: String
}

extension User {
    static var Mock: User {
        
        .init(id: 1, fullName: "Israhel Nanaea Irma", birthDate: Date(), email: "test@test.com", phone: "+34666666666", address: "California 3", country: "Spain")
    }
}
