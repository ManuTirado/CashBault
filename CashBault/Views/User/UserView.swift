//
//  ExploreView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject var appState: AppState
    @State private var showLogoutConfirmation: Bool = false
    
    var body: some View {
        NavigationStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Constants.backgroundColorGradient)
                .customNavigationBar(
                    customCenterContent: {
                        Text(L10n.tabUserTitle)
                            .modifier(TextModifier(size: 16, weight: .bold, color: .white))
                    }
                )
        }
    }
    
    @ViewBuilder
    var content: some View {
        ZStack {
            if appState.user != nil {
                ScrollView {
                    VStack(spacing: 24) {
                        DropDownButtonView(title: L10n.userPersonalInfoLabel, openedView: personalData)
                        DropDownButtonView(title: L10n.userConfigLabel, openedView: config)
                        logoutButton
                    }
                    .padding()
                }
                .scrollIndicators(.never)
            } else {
                Spacer()
            }
            if showLogoutConfirmation {
                logoutConfirmationPopup
            }
        }
    }
    
    @ViewBuilder
    var personalData: some View {
        if let user = appState.user {
            VStack(spacing: 0) {
                AccountInfoCellView(image: Image(systemName: "character.textbox"), title: user.fullName) {
                    
                }
                Rectangle()
                    .fill(Asset.Colors.secondaryColor.swiftUIColor)
                    .frame(height: 1)
                AccountInfoCellView(image: Image(systemName: "sofa"), title: "\(user.address) - \(user.country)") {
                    
                }
                Rectangle()
                    .fill(Asset.Colors.secondaryColor.swiftUIColor)
                    .frame(height: 1)
                AccountInfoCellView(image: Image(systemName: "birthday.cake"), title: user.birthDate.description) {
                    
                }
                Rectangle()
                    .fill(Asset.Colors.secondaryColor.swiftUIColor)
                    .frame(height: 1)
                AccountInfoCellView(image: Image(systemName: "envelope"), title: user.email) {
                    
                }
                Rectangle()
                    .fill(Asset.Colors.secondaryColor.swiftUIColor)
                    .frame(height: 1)
                AccountInfoCellView(image: Image(systemName: "phone"), title: user.phone) {
                    
                }
            }
        }
    }
    
    @ViewBuilder
    var config: some View {
        VStack(spacing: 0) {
            AccountInfoCellView(image: Image(systemName: "globe"), title: "\(L10n.userConfigLanguage) - TODO") {
                
            }
        }
    }
    
    @ViewBuilder
    var logoutButton: some View {
        Button {
            showLogoutConfirmation = true
        } label: {
            HStack(spacing: 24) {
                Image(systemName: "arrow.right.to.line")
                    .foregroundStyle(Asset.Colors.primaryColor.swiftUIColor)
                Text(L10n.userLogoutLabel)
                    .modifier(TextModifier(size: 18, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                Spacer()
            }
            .padding()
            .background(Asset.Colors.error.swiftUIColor.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
    
    @ViewBuilder
    var logoutConfirmationPopup: some View {
        ZStack {
            Color.black.opacity(0.5)
                .onTapGesture {
                    showLogoutConfirmation = false
                }
            
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .foregroundStyle(Asset.Colors.error.swiftUIColor)
                    Text(L10n.userLogoutConfirmationTitle)
                        .modifier(TextModifier(size: 22, weight: .black, color: Asset.Colors.primaryColor.swiftUIColor))
                        .padding(.bottom, 32)
                    Text(L10n.userLogoutConfirmationMessage)
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
                        showLogoutConfirmation = false
                    } label: {
                        Text(L10n.cancel.uppercased())
                            .modifier(TextModifier(size: 18, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                            .padding()
                    }
                    Button {
                        showLogoutConfirmation = false
                        appState.user = nil
                    } label: {
                        Text(L10n.accept.uppercased())
                            .modifier(TextModifier(size: 18, weight: .bold, color: Asset.Colors.error.swiftUIColor))
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
    UserView()
        .environmentObject(AppState.Mock)
}
