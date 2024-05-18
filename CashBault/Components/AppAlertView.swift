//
//  AppAlertView.swift
//  CashBault
//
//  Created by manueltirado on 15/5/24.
//

import SwiftUI

struct AppAlertView: View {
    
    @Binding var showAlert: Bool
    let image: Image
    let imageColor: Color
    let title: String
    let description: String
    let confirmAction: () -> Void
    var cancelAction: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
            
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .foregroundStyle(imageColor)
                    Text(title)
                        .modifier(TextModifier(size: 22, weight: .black, color: Asset.Colors.primaryColor.swiftUIColor))
                        .padding(.bottom, 32)
                    Text(description)
                        .modifier(TextModifier(size: 20, weight: .regular, color: Asset.Colors.primaryColor.swiftUIColor))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)
                }
                .padding()
                Rectangle()
                    .fill(Asset.Colors.secondaryColor.swiftUIColor)
                    .frame(height: 1)
                HStack(spacing: 16) {
                    Spacer(minLength: 0)
                    Button {
                        cancelAction?()
                        showAlert = false
                    } label: {
                        Text(L10n.cancel.uppercased())
                            .modifier(TextModifier(size: 18, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                            .padding()
                    }
                    Button {
                        confirmAction()
                        showAlert = false
                    } label: {
                        Text(L10n.accept.uppercased())
                            .modifier(TextModifier(size: 18, weight: .bold, color: Asset.Colors.accentColor.swiftUIColor))
                            .padding()
                    }
                }
                .background(.black.opacity(0.2))
            }
            .background(Asset.Colors.lightBackground.swiftUIColor)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Asset.Colors.secondaryColor.swiftUIColor, lineWidth: 1)
            }
            .padding()
        }
    }
}

#Preview {
    AppAlertView(showAlert: .constant(true),
                 image: Image(systemName: "exclamationmark.triangle"),
                 imageColor: Asset.Colors.error.swiftUIColor,
                 title: L10n.userLogoutConfirmationTitle,
                 description: L10n.userLogoutConfirmationMessage) {
        
    }
}
