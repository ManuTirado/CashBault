//
//  AppButtonView.swift
//  CashBault
//
//  Created by manueltirado on 10/5/24.
//

import SwiftUI

struct AppButtonView: View {
    
    var icon: Image? = nil
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                icon
                    .foregroundStyle(Asset.Colors.primaryColor.swiftUIColor)
                Text(text)
                    .modifier(TextModifier(size: 18, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
            }
            .padding(8)
            .background(Constants.accentColorGradient)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    VStack {
        AppButtonView(icon: Image(systemName: "square.and.arrow.up.fill"), text: "Test") {}
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Constants.backgroundColorGradient)
}
