//
//  HomeView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var accountsModel: AccountsModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                movements
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red)
            .customNavigationBar(
                customCenterContent: {
                    Text(L10n.tabHomeTitle)
                        .modifier(TextModifier(size: 16, weight: .bold, color: .white))
                }
            )
        }
    }
    
    @ViewBuilder
    var header: some View {
        Text("Header")
    }
    
    @ViewBuilder
    var movements: some View {
        Spacer()
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(AppState())
    .environmentObject(AccountsModel())
}
