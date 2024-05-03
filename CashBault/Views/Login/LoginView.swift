//
//  LoginView.swift
//  CashBault
//
//  Created by manueltirado on 30/4/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Login View")
            Button {
                appState.user = User.Mock
            } label: {
                Text("LOGIN")
                    .padding()
                    .background(Color.yellow)
                    .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    LoginView()
}
