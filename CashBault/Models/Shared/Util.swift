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
    
    enum FormattTypes {
        case weekName_day_monthName
        
        var formattStr: String {
            switch self {
            case .weekName_day_monthName:
                "EEEE d MMMM"
            }
        }
    }
    
    static func getFormattedDate(date: Date, formatt: FormattTypes) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = formatt.formattStr
        return dateFormatter.string(from: date)
    }
}
