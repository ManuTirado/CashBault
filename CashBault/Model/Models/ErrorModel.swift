//
//  ErrorModel.swift
//  CashBault
//
//  Created by manueltirado on 9/5/24.
//

import Foundation

enum AppError: Error {
    case timeOut
    case serverError
    case badRequest
    case custom(String)
    
    var errorMsg: String {
        switch self {
        case .timeOut:
            return L10n.errorTimeOutMessage
        case .serverError:
            return L10n.errorServerErrorMessage
        case .badRequest:
            return L10n.errorBadRequestMessage
        case .custom(let msg):
            return msg
        }
    }
}
