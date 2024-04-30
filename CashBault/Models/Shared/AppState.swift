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

struct User {
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
