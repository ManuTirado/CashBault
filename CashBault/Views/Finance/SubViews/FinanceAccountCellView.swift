//
//  FinanceAccountCellView.swift
//  CashBault
//
//  Created by manueltirado on 10/5/24.
//

import SwiftUI

struct FinanceAccountCellView: View {
    
    let account: Account
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "rectangle.fill.on.rectangle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(Asset.Colors.accentColor .swiftUIColor)
            Text(account.name)
                .modifier(TextModifier(size: 16, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
            Spacer(minLength: 0)
            Text("\(Util.getTwoDigitStr(num: account.balance)) \(account.currencySymbol)")
                .modifier(TextModifier(size: 16, weight: .regular, color: Asset.Colors.primaryColor.swiftUIColor))
        }
        .padding()
        .background(Asset.Colors.lightBackground.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    FinanceAccountCellView(account: Account.Mock1)
}
