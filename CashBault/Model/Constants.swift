//
//  Constants.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import Foundation
import SwiftUI

struct Constants {
    
    enum AppLangs: String, CaseIterable {
        case en
        case es
    }
    
    static let defaultsLangKey = "user_defaults_lang"
    
    static let backgroundColorGradient = LinearGradient(colors: [Asset.Colors.background.swiftUIColor,
                                                                 Asset.Colors.darkBackground.swiftUIColor],
                                                        startPoint: .topLeading, endPoint: .bottomTrailing)
    static let accentColorGradient = LinearGradient(colors: [Asset.Colors.accentColor.swiftUIColor,
                                                             Asset.Colors.darkAccentColor.swiftUIColor],
                                                    startPoint: .topLeading, endPoint: .bottomTrailing)
}
