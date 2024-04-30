//
//  FinanceView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct FinanceView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Finance View")
            Button {
                appState.user = nil
            } label: {
                Text("Volver al Login")
                    .padding()
                    .clipShape(Capsule())
                    .background(Color.yellow)
            }
        }
    }
}

#Preview {
    FinanceView()
        .environmentObject(AppState())
}
