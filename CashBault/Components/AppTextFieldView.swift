//
//  AppTextFieldView.swift
//  CashBault
//
//  Created by manueltirado on 9/5/24.
//

import SwiftUI

struct AppTextFieldView: View {
    
    enum TextFieldValidators {
        case none
        case empty
        case email
        case password
        
        func isValid(value: String) -> Bool {
            switch self {
            case .none:
                return true
            case .empty:
                return !value.isEmpty
            case .email:
                if !value.isEmpty {
                    let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                    let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
                    return pred.evaluate(with: value)
                } else {
                    return true
                }
            case .password:
                if !value.isEmpty {
                    let regEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
                    let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
                    return pred.evaluate(with: value)
                } else {
                    return true
                }
            }
        }
        
        var errorMessage: String {
            switch self {
            case .none:
                return ""
            case .empty:
                return L10n.errorEmpty
            case .email:
                return L10n.errorEmail
            case .password:
                return L10n.errorPassword
            }
        }
    }
    
    @State private var errorMessage: String = ""
    @State var isTextVisible: Bool
    @Binding var value: String
    @Binding var isValid: Bool
    var placeHolder: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType
    var validators: [TextFieldValidators]
    var leftImage: Image?
    
    init(value: Binding<String>, isValid: Binding<Bool> = .constant(true), placeHolder: String, isSecure: Bool, keyboard: UIKeyboardType = .default, validators: [TextFieldValidators] = [], leftImage: Image? = nil) {
        self.isTextVisible = !isSecure
        self._value = value
        self._isValid = isValid
        self.placeHolder = placeHolder
        self.isSecure = isSecure
        self.keyboardType = keyboard
        self.validators = validators
        self.leftImage = leftImage
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let leftImage {
                    leftImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(Asset.Colors.primaryColor.swiftUIColor)
                        .frame(width: 30)
                }
                ZStack(alignment: .leading) {
                    Text(placeHolder)
                        .opacity(value.isEmpty ? 0.7 : 0)
                    Group {
                        if isTextVisible {
                            TextField("", text: $value)
                        } else {
                            SecureField("", text: $value)
                        }
                    }
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(.never)
                }
                .modifier(TextModifier(size: 18, weight: .regular, color: Asset.Colors.primaryColor.swiftUIColor))
                .animation(.easeInOut(duration: 0.05), value: value.isEmpty)
                if isSecure {
                    Button {
                        isTextVisible.toggle()
                    } label: {
                        Image(systemName: isTextVisible ? "eye" : "eye.slash.fill")
                            .scaleEffect(1.25)
                            .foregroundStyle(Asset.Colors.accentColor.swiftUIColor)
                    }
                }
            }
            .padding()
            .frame(height: 60)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Asset.Colors.background.swiftUIColor)
            )
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .modifier(TextModifier(size: 14, weight: .regular, color: Asset.Colors.error.swiftUIColor))
                    .padding(.horizontal, 8)
                    .animation(.easeInOut(duration: 0.2), value: errorMessage)
            }
        }
        .onChange(of: value) { _, newValue in
            validateValue(value: newValue)
        }
    }
    
    private func validateValue(value: String) {
        var errorMsg: String = ""
        validators.forEach { validator in
            if !validator.isValid(value: value) {
                errorMsg = validator.errorMessage
            }
        }
        if errorMsg.isEmpty {
            isValid = true
            errorMessage = ""
        } else {
            isValid = false
            errorMessage = errorMsg
        }
    }
}

struct AppTextFieldStaticView: View {
    
    let value: String
    var leftImage: Image?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let leftImage {
                    leftImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(Asset.Colors.primaryColor.swiftUIColor)
                        .frame(width: 30)
                }
                Text(value)
                    .modifier(TextModifier(size: 18, weight: .regular, color: Asset.Colors.primaryColor.swiftUIColor))
                    .animation(.easeInOut(duration: 0.05), value: value.isEmpty)
                Spacer()
            }
            .padding()
            .frame(height: 60)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Asset.Colors.background.swiftUIColor)
            )
        }
    }
}

#Preview {
    VStack {
        AppTextFieldView(value: .constant(""), placeHolder: "Placeholder", isSecure: false)
        AppTextFieldView(value: .constant(""), placeHolder: "Placeholder", isSecure: true)
        AppTextFieldStaticView(value: "Test", leftImage: Image(systemName: "sofa"))
        AppTextFieldStaticView(value: "Test", leftImage: Image(systemName: "phone"))
    }
    .padding()
}
