//
//  FinanceAddAccountView.swift
//  CashBault
//
//  Created by manueltirado on 10/5/24.
//

import SwiftUI

struct FinanceAddAccountView: View {
    @FocusState var focus: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var accountsModel: AccountsModel
    @Binding var financeViewToast: Toast?
    @State private var toast: Toast? = nil
    @State private var name: String = ""
    @State private var selectedAccountType: Account.AccountType = .normal
    @State private var currencies: [AccountCurrencyDTO] = []
    @State private var selectedCurrency: AccountCurrencyDTO? = nil
    @State private var showAccountTypePicker: Bool = false
    @State private var showCurrencyPicker: Bool = false
    private var selectedAccountTypeName: String {
        switch selectedAccountType {
        case .normal:
            return L10n.accountTypeNormalTitle
        case .saving:
            return L10n.accountTypeSavingTitle
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Constants.backgroundColorGradient)
        .toastView(toast: $toast)
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
        .fullScreenCover(isPresented: $showAccountTypePicker) {
            accountTypePicker
        }
        .fullScreenCover(isPresented: $showCurrencyPicker) {
            currencyPicker
        }
        .onAppear {
            Task {
                await getCurrencies()
            }
        }
    }
    
    @ViewBuilder
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                Text(L10n.name.uppercased())
                    .modifier(TextModifier(size: 16, weight: .black, color: Asset.Colors.secondaryColor.swiftUIColor))
                AppTextFieldView(value: $name, placeHolder: L10n.name, isSecure: false, validators: [.empty])
                    .focused($focus)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(L10n.accountTypeTitle.uppercased())
                    .modifier(TextModifier(size: 16, weight: .black, color: Asset.Colors.secondaryColor.swiftUIColor))
                AppTextFieldStaticView(value: selectedAccountTypeName)
                    .onTapGesture {
                        focus = false
                        showAccountTypePicker = true
                    }
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(L10n.currency.uppercased())
                    .modifier(TextModifier(size: 16, weight: .black, color: Asset.Colors.secondaryColor.swiftUIColor))
                AppTextFieldStaticView(value: selectedCurrency != nil ? "\(selectedCurrency?.name ?? "") - \(selectedCurrency?.symbol ?? "")" : L10n.currency)
                    .onTapGesture {
                        focus = false
                        showCurrencyPicker = true
                    }
            }
        }
        Spacer(minLength: 0)
        addButton
    }
    
    @ViewBuilder
    var addButton: some View {
        AppButtonView(text: L10n.financeAddAccountLabel.uppercased()) {
            Task {
                await createAccount()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    @ViewBuilder
    var accountTypePicker: some View {
        VStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    showAccountTypePicker = false
                }
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        showAccountTypePicker = false
                    } label: {
                        Text(L10n.accept.uppercased())
                            .modifier(TextModifier(size: 14, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                            .padding()
                    }
                }
                Rectangle()
                    .fill(Asset.Colors.secondaryColor.swiftUIColor)
                    .frame(height: 1)
                Picker("", selection: $selectedAccountType) {
                    ForEach(Account.AccountType.allCases, id: \.self) { type in
                        Group {
                            switch type {
                            case .normal:
                                Text(L10n.accountTypeNormalTitle)
                            case .saving:
                                Text(L10n.accountTypeSavingTitle)
                            }
                        }
                        .modifier(TextModifier(size: 16, weight: .bold,
                                               color: selectedAccountType == type ? Asset.Colors.accentColor.swiftUIColor : Asset.Colors.primaryColor.swiftUIColor))
                    }
                }
                .pickerStyle(.wheel)
            }
            .background(Constants.backgroundColorGradient)
        }
        .presentationBackground(.clear)
    }
    
    @ViewBuilder
    var currencyPicker: some View {
        VStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    showCurrencyPicker = false
                }
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        showCurrencyPicker = false
                    } label: {
                        Text(L10n.accept.uppercased())
                            .modifier(TextModifier(size: 14, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                            .padding()
                    }
                }
                Rectangle()
                    .fill(Asset.Colors.secondaryColor.swiftUIColor)
                    .frame(height: 1)
                Picker("", selection: $selectedCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text("\(currency.name) - \(currency.symbol)")
                            .modifier(TextModifier(size: 16, weight: .bold,
                                                   color: selectedCurrency?.id == currency.id ? Asset.Colors.accentColor.swiftUIColor : Asset.Colors.primaryColor.swiftUIColor))
                            .tag(currency as AccountCurrencyDTO?)
                    }
                }
                .pickerStyle(.wheel)
            }
            .background(Constants.backgroundColorGradient)
        }
        .presentationBackground(.clear)
    }
}

extension FinanceAddAccountView {
    
    private func getCurrencies() async {
        do {
            currencies = try await AccountInterface.getCurrencies()
            selectedCurrency = currencies.first
        } catch {
            toast = .init(L10n.errorBadRequestMessage)
        }
    }
    
    private func createAccount() async {
        do {
            if name.isEmpty || selectedCurrency == nil {
                toast = .init(L10n.loginEmptyFieldsError)
            } else {
                try await AccountInterface.createAccount()
                financeViewToast = .init(L10n.financeAddAccountOkResponse)
                dismiss()
            }
        } catch {
            toast = .init(L10n.errorBadRequestMessage)
        }
    }
}

#Preview {
    FinanceAddAccountView(financeViewToast: .constant(nil))
        .environmentObject(AccountsModel.Mock)
}
