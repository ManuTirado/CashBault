//
//  LoginView.swift
//  CashBault
//
//  Created by manueltirado on 30/4/24.
//

import SwiftUI

struct LoginView: View {
    
    enum FocusedField {
        case email, password
    }
    
    @EnvironmentObject var appState: AppState
    @FocusState private var focusedField: FocusedField?
    @State private var isLoading: Bool = false
    @State private var toast: Toast? = nil
    @State private var emailField: String = ""
    @State private var isEmailValid: Bool = false
    @State private var passwordField: String = ""
    @State private var isPasswordValid: Bool = false
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    focusedField = nil
                }
            VStack {
                Text(L10n.appName)
                    .modifier(TextModifier(size: 40, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                    .frame(alignment: .top)
                Spacer()
                textFields
                Spacer()
                buttons
                Spacer()
            }
            .disabled(isLoading ? true : false)
        }
        .toastView(toast: $toast)
    }
    
    @ViewBuilder
    var textFields: some View {
        VStack {
            AppTextFieldView(value: $emailField, isValid: $isEmailValid, placeHolder: L10n.emailPlaceholder, isSecure: false, keyboard: .emailAddress, validators: [.empty, .email])
                .padding(.horizontal, 16)
                .focused($focusedField, equals: .email)
            
            AppTextFieldView(value: $passwordField, isValid: $isPasswordValid, placeHolder: L10n.passwordPlaceholder, isSecure: true, validators: [.empty, .password])
                .padding(.horizontal, 16)
                .focused($focusedField, equals: .password)
        }
    }
    
    @ViewBuilder
    var buttons: some View {
        VStack(spacing: 8) {
            Button {
                Task {
                    await doLogin()
                }
            } label: {
                Text(L10n.login.uppercased())
                    .modifier(TextModifier(size: 16, weight: .black, color: Asset.Colors.primaryColor.swiftUIColor))
                    .opacity(isLoading ? 0 : 1)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Constants.accentColorGradient)
                    .clipShape(Capsule())
                    .padding(.horizontal, 32)
                    .overlay {
                        LoaderView()
                            .opacity(isLoading ? 1 : 0)
                    }
            }
            Button {
                Task {
                    await doBiometricLogin()
                }
            } label: {
                Text(L10n.useBiometricLabel)
                    .modifier(TextModifier(size: 14, weight: .bold, color: Asset.Colors.primaryColor.swiftUIColor))
                    .padding()
            }
        }
    }
}

extension LoginView {
    private func doLogin() async {
        focusedField = nil
        isLoading = true
        do {
            if emailField.isEmpty || passwordField.isEmpty {
                toast = .init(L10n.loginEmptyFieldsError)
            } else if !isEmailValid || !isPasswordValid {
                toast = .init(L10n.loginValidFieldsError)
            } else {
                appState.user = try await UserInterface.doLogin(user: emailField, password: passwordField)
            }
        } catch let error as AppError {
            toast = .init(error.errorMsg)
        } catch {
            toast = .init(L10n.loginError)
        }
        isLoading = false
    }
    
    private func doBiometricLogin() async {
        // TODO: - Implement biometric login
        focusedField = nil
        isLoading = true
        do {
            appState.user = try await UserInterface.doBiometricLogin(user: "", password: "")
        } catch let error as AppError {
            toast = .init(error.errorMsg)
        } catch {
            toast = .init(error.localizedDescription)
        }
        isLoading = false
    }
}

#Preview {
    LoginView()
        .background(Constants.backgroundColorGradient)
        .environmentObject(AppState())
}
