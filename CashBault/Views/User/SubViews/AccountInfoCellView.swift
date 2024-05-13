//
//  AccountInfoCellView.swift
//  CashBault
//
//  Created by manueltirado on 13/5/24.
//

import SwiftUI

struct AccountInfoCellView: View {
    
    let image: Image
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 0) {
                image
                    .foregroundStyle(Asset.Colors.primaryColor.swiftUIColor)
                    .padding(.trailing, 16)
                Text(title)
                    .modifier(TextModifier(size: 18, weight: .heavy, color: Asset.Colors.primaryColor.swiftUIColor))
                Spacer()
            }
            .padding()
            .background(Asset.Colors.background.swiftUIColor)
        }
    }
}

#Preview {
    AccountInfoCellView(image: Image(systemName: "phone"), title: "test") { }
}
