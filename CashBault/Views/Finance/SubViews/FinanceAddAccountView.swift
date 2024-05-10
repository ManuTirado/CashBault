//
//  FinanceAddAccountView.swift
//  CashBault
//
//  Created by manueltirado on 10/5/24.
//

import SwiftUI

struct FinanceAddAccountView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var accountsModel: AccountsModel

    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Constants.backgroundColorGradient)
        .customNavigationBar(
            customLeftContent: {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            },
            customCenterContent: {
                Text(L10n.financeAddAccountTitle)
                    .modifier(TextModifier(size: 16, weight: .bold, color: .white))
            }
        )
    }
    
    @ViewBuilder
    var content: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    FinanceAddAccountView()
        .environmentObject(AccountsModel.Mock)
}
