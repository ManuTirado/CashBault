//
//  AccountCellView.swift
//  CashBault
//
//  Created by manueltirado on 6/5/24.
//

import SwiftUI

struct AccountCellView: View {
    
    let account: Account
    @Binding var isLoading: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(account.name)
                        .modifier(TextModifier(size: 22, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                    Text(account.type.title)
                        .modifier(TextModifier(size: 18, weight: .regular, color: Asset.Colors.secondaryColor.swiftUIColor))
                }
                HStack(spacing: 0) {
                    Text(Util.getTwoDigitStr(num: account.balance))
                    Text(account.currencySymbol)
                }
                .modifier(TextModifier(size: 26, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
            }
            Spacer(minLength: 0)
            VStack(spacing: 0) {
                Image(systemName: "rectangle.fill.on.rectangle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Asset.Colors.accentColor .swiftUIColor)
            }
        }
        .padding()
        .modifier(LoadingShimmeringModifierV2(isLoading: $isLoading))
        .background(Asset.Colors.lightBackground.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    AccountCellView(account: Account.Mock1, isLoading: .constant(true))
        .padding()
}
