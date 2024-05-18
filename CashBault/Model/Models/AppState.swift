//
//  AppState.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    
    @AppStorage(Constants.defaultsLangKey) var lang = Locale.current.language.languageCode?.identifier ?? ""
    @Published var user: User?
    
    init(user: User? = nil) {
        self.user = user
    }
}

extension AppState {
    public static var Mock: AppState {
        let appState = AppState()
        appState.user = User.Mock
        return appState
    }
}
