//
//  ExploreView.swift
//  CashBault
//
//  Created by manueltirado on 29/4/24.
//

import SwiftUI

struct UserView: View {
    
    enum FocusedField {
        case name
        case address
        case email
        case phone
    }
    
    @FocusState var focus: FocusedField?
    @EnvironmentObject var appState: AppState
    @State private var toast: Toast? = nil
    @State private var isLoading: Bool = false
    @State private var showDatePicker: Bool = false
    @State private var showLogoutConfirmation: Bool = false
    @State private var userAux: User = User()
    var somethingChanged: Bool {
        return appState.user != userAux
    }
    
    var body: some View {
        NavigationStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Constants.backgroundColorGradient)
                .toastView(toast: $toast)
                .customNavigationBar(
                    customCenterContent: {
                        Text(L10n.tabUserTitle)
                            .modifier(TextModifier(size: 16, weight: .bold, color: .white))
                    }
                )
                .onAppear {
                    self.initData()
                }
                .fullScreenCover(isPresented: $showDatePicker) {
                    datePicker
                }
        }
    }
    
    @ViewBuilder
    var content: some View {
        ZStack(alignment: .bottom) {
            if appState.user != nil {
                ScrollView {
                    VStack(spacing: 24) {
                        DropDownButtonView(title: L10n.userPersonalInfoLabel, openedView: personalData)
                        DropDownButtonView(title: L10n.userConfigLabel, openedView: config)
                        logoutButton
                        saveButton
                            .padding()
                            .opacity(somethingChanged && focus != nil ? 1 : 0)
                            .animation(.easeInOut, value: somethingChanged)
                    }
                    .padding()
                    .padding(.bottom, 70)
                }
                .scrollIndicators(.never)
            } else {
                Spacer()
            }
            if somethingChanged && focus == nil {
                saveButton
                    .padding()
                    .transition(.opacity)
                    .animation(.easeInOut, value: somethingChanged)
            }
            if showLogoutConfirmation {
                logoutConfirmationPopup
            }
        }
    }
    
    @ViewBuilder
    var personalData: some View {
        VStack(spacing: 0) {
            AccountInfoCellView(value: $userAux.fullName, image: Image(systemName: "character.textbox"), placeHolder: L10n.fullNamePlaceholder)
                .focused($focus, equals: .name)
            
            separator
            
            AccountInfoCellView(value: $userAux.address, image: Image(systemName: "sofa"), placeHolder: L10n.addressPlaceholder)
                .focused($focus, equals: .address)
            
            separator
            
            AccountInfoStaticCellView(value: Util.getFormattedDate(date: userAux.birthDate, formatt: .day_month_year), image: Image(systemName: "birthday.cake")) {
                openDatePicker()
            }
            
            separator
            
            AccountInfoCellView(value: $userAux.email, image: Image(systemName: "envelope"), placeHolder: L10n.emailPlaceholder)
                .focused($focus, equals: .email)
            
            separator
            
            AccountInfoCellView(value: $userAux.phone, image: Image(systemName: "phone"), placeHolder: L10n.phonePlaceholder)
                .focused($focus, equals: .phone)
        }
    }
    
    @ViewBuilder
    var config: some View {
        VStack(spacing: 0) {
            //            AccountInfoCellView(image: Image(systemName: "globe"), title: "\(L10n.userConfigLanguage) - TODO") {
            //
            //            }
        }
    }
    
    @ViewBuilder
    var logoutButton: some View {
        Button {
            focus = nil
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
    var saveButton: some View {
        Button {
            focus = nil
            Task {
                await saveUserData()
            }
        } label: {
            HStack(spacing: 24) {
                Text(L10n.save)
                    .modifier(TextModifier(size: 18, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
            }
            .padding()
            .padding(.horizontal, 32)
            .background(
                Color.black.overlay(Asset.Colors.succesGreen.swiftUIColor.opacity(0.7))
            )
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
    
    @ViewBuilder
    var datePicker: some View {
        VStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    showDatePicker = false
                }
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        showDatePicker = false
                    } label: {
                        Text(L10n.accept.uppercased())
                            .modifier(TextModifier(size: 14, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                            .padding()
                    }
                }
                separator
                DatePicker("", selection: $userAux.birthDate, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .preferredColorScheme(.dark)
                    .tint(Asset.Colors.accentColor.swiftUIColor)
            }
            .background(Constants.backgroundColorGradient)
        }
        .presentationBackground(Color.clear)
    }
    
    @ViewBuilder
    var separator: some View {
        Rectangle()
            .fill(Asset.Colors.secondaryColor.swiftUIColor)
            .frame(height: 1)
    }
}

extension UserView {
    
    private func initData() {
        if let user = appState.user {
            self.userAux = user
        }
    }
    
    private func openDatePicker() {
        focus = nil
        showDatePicker = true
    }
    
    private func saveUserData() async {
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            if userAux != appState.user {
                if userAux.fullName.isEmpty || userAux.address.isEmpty || userAux.email.isEmpty || userAux.phone.isEmpty {
                    toast = .init(L10n.loginEmptyFieldsError)
                } else {
                    appState.user = userAux
                }
            }
        } catch {
            toast = .init(L10n.errorBadRequestMessage)
        }
    }
}

#Preview {
    UserView()
        .environmentObject(AppState.Mock)
}
