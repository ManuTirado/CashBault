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
        case day_month_year
        
        var formattStr: String {
            switch self {
            case .weekName_day_monthName:
                "EEEE d MMMM"
            case .day_month_year:
                "dd/MM/yyyy"
            }
        }
    }
    
    static func getFormattedDate(date: Date, formatt: FormattTypes) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: UserDefaults.standard.string(forKey: Constants.defaultsLangKey) ?? "en")
        dateFormatter.dateFormat = formatt.formattStr
        return dateFormatter.string(from: date)
    }
}
