//
//  ExploreView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Explore View")
            Button {
                appState.user = nil
            } label: {
                Text("Volver al Login")
                    .modifier(TextModifier(size: 22, weight: .bold, color: .black))
                    .padding()
                    .clipShape(Capsule())
                    .background(Color.yellow)
            }
        }
    }
}

#Preview {
    ExploreView()
        .environmentObject(AppState())
}
