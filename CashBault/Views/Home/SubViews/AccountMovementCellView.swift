//
//  AccountMovementCellView.swift
//  CashBault
//
//  Created by manueltirado on 7/5/24.
//

import SwiftUI

struct AccountMovementCellView: View {
    
    let movement: AccountMovement
    private var isIncome: Bool {
        movement.quantity >= 0
    }
    
    var body: some View {
        HStack(spacing: 4) {
            VStack {
                switch movement.state {
                case .cancelled:
                    Image(systemName: "slash.circle")
                        .resizable()
                default:
                    Image(systemName: isIncome ? "bag.badge.plus" : "bag.badge.minus")
                        .resizable()
                }
            }
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(Asset.Colors.primaryColor.swiftUIColor)
            .frame(width: 30)
            .padding(.trailing, 12)
            VStack(alignment: .leading, spacing: 4) {
                Text(movement.concept)
                    .modifier(TextModifier(size: 16, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                Text(isIncome ? L10n.accountMovementSenderFrom(movement.sender) : L10n.accountMovementSenderTo(movement.sender))
                    .modifier(TextModifier(size: 16, weight: .regular, color: Asset.Colors.secondaryColor.swiftUIColor))
            }
            .lineLimit(1)
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                HStack(spacing: 0) {
                    Text(Util.getTwoDigitStr(num: movement.quantity))
                        .lineLimit(1)
                    Text(movement.currencySymbol)
                }
                .modifier(TextModifier(size: 16, weight: .bold, color: isIncome ? Asset.Colors.background.swiftUIColor : Asset.Colors.primaryColor.swiftUIColor))
                .padding(.horizontal, 2)
                .padding(.vertical, 4)
                .background(
                    VStack {
                        if isIncome {
                            Asset.Colors.succesGreen.swiftUIColor
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                )
                .overlay {
                    if movement.state == .cancelled {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(isIncome ? Asset.Colors.background.swiftUIColor : Asset.Colors.primaryColor.swiftUIColor)
                            .padding(.horizontal, 2)
                    }
                }
                
                if movement.state == .pending {
                    Text(L10n.pending)
                        .modifier(TextModifier(size: 14, weight: .regular, color: Asset.Colors.secondaryColor.swiftUIColor))
                } else if movement.state == .cancelled {
                    Text(L10n.cancelled)
                        .modifier(TextModifier(size: 14, weight: .bold, color: Asset.Colors.error.swiftUIColor.opacity(0.7)))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 8)
        .frame(height: 70)
        .background(Asset.Colors.background.swiftUIColor)
    }
}

#Preview {
    AccountMovementCellView(movement: AccountMovement.Mock3)
}
