//
//  UserDTO.swift
//  CashBault
//
//  Created by manueltirado on 16/5/24.
//

import Foundation

struct User: Equatable {
    var id: Int
    var fullName: String
    var birthDate: Date
    var email: String
    var phone: String
    var address: String
    
    init(id: Int, fullName: String, birthDate: Date, email: String, phone: String, address: String) {
        self.id = id
        self.fullName = fullName
        self.birthDate = birthDate
        self.email = email
        self.phone = phone
        self.address = address
    }
    
    init() {
        self.id = -1
        self.fullName = ""
        self.birthDate = Date()
        self.email = ""
        self.phone = ""
        self.address = ""
    }
}

extension User {
    
    static var Mock: User {
        .init(id: 1, fullName: "Israhel Nanaea Irma", birthDate: Date(), email: "test@test.com", phone: "+34666666666", address: "California 3")
    }
}
