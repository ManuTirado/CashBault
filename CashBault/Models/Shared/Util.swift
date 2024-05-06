//
//  Util.swift
//  CashBault
//
//  Created by manueltirado on 6/5/24.
//

import Foundation

struct Util {
    
    static func getTwoDigitStr(num: Double) -> String {
        String(format: "%.2f", num)
    }
}
