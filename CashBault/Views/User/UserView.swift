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
    @State private var showLangPicker: Bool = false
    @State private var showLogoutConfirmation: Bool = false
    @State private var showReloadAppPopup: Bool = false
    @State private var userAux: User = User()
    @State private var langAux: String = ""
    var somethingChanged: Bool {
        return appState.user != userAux || langAux != appState.lang
    }
    
    var body: some View {
        NavigationStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Constants.backgroundColorGradient)
                .toastView(toast: $toast)
                .background(pickers)
                .customNavigationBar(
                    customCenterContent: {
                        Text(L10n.tabUserTitle)
                            .modifier(TextModifier(size: 16, weight: .bold, color: .white))
                    }
                )
                .onAppear {
                    self.initData()
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
            } else if showReloadAppPopup {
                reloadAppPopup
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
            AccountInfoStaticCellView(value: "\(L10n.userConfigLanguage) - \(langAux.uppercased())", image: Image(systemName: "globe")) {
                openLangPicker()
            }
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
            shouldSaveUserData()
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
        AppAlertView(showAlert: $showLogoutConfirmation,
                     image: Image(systemName: "exclamationmark.triangle"),
                     imageColor: Asset.Colors.error.swiftUIColor,
                     title: L10n.userLogoutConfirmationTitle,
                     description: L10n.userLogoutConfirmationMessage) {
            appState.user = nil
        }
    }
    
    @ViewBuilder
    var reloadAppPopup: some View {
        AppAlertView(showAlert: $showReloadAppPopup,
                     image: Image(systemName: "exclamationmark.triangle"),
                     imageColor: Asset.Colors.error.swiftUIColor,
                     title: L10n.userSaveChangesConfirmationTitle,
                     description: L10n.userSaveChangesConfirmationMessage) {
            Task {
                await saveUserData()
            }
        }
    }
    
    @ViewBuilder
    var pickers: some View {
        EmptyView()
            .fullScreenCover(isPresented: $showDatePicker) {
                datePicker
            }
            .fullScreenCover(isPresented: $showLangPicker) {
                langPicker
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
        .presentationBackground(.clear)
    }
    
    @ViewBuilder
    var langPicker: some View {
        VStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    showLangPicker = false
                }
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        showLangPicker = false
                    } label: {
                        Text(L10n.accept.uppercased())
                            .modifier(TextModifier(size: 14, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                            .padding()
                    }
                }
                separator
                Picker("", selection: $langAux) {
                    ForEach(Constants.AppLangs.allCases, id: \.rawValue) { langCode in
                        Text(langCode.rawValue.uppercased())
                            .modifier(TextModifier(size: 16, weight: .bold,
                                                   color: langCode.rawValue == langAux ? Asset.Colors.accentColor.swiftUIColor : Asset.Colors.primaryColor.swiftUIColor))
                    }
                }
                .pickerStyle(.wheel)
            }
            .background(Constants.backgroundColorGradient)
        }
        .presentationBackground(.clear)
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
        self.langAux = appState.lang
    }
    
    private func openLangPicker() {
        focus = nil
        showLangPicker = true
    }
    
    private func openDatePicker() {
        focus = nil
        showDatePicker = true
    }
    
    private func shouldSaveUserData() {
        if langAux != appState.lang {
            showReloadAppPopup = true
        } else {
            Task {
                await saveUserData()
            }
        }
    }
    
    private func saveUserData() async {
        do {
            if userAux != appState.user {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                if userAux.fullName.isEmpty || userAux.address.isEmpty || userAux.email.isEmpty || userAux.phone.isEmpty {
                    toast = .init(L10n.loginEmptyFieldsError)
                } else {
                    appState.user = userAux
                }
            }
            if langAux != appState.lang {
                appState.lang = langAux
                exit(0)
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
