//
//  AccountInfoCellView.swift
//  CashBault
//
//  Created by manueltirado on 13/5/24.
//

import SwiftUI

struct AccountInfoCellView: View {

    @Binding var value: String
    let image: Image
    let placeHolder: String
    
    var body: some View {
        AppTextFieldView(value: $value, isValid: .constant(true), placeHolder: placeHolder, isSecure: false, validators: [.empty], leftImage: image)
    }
}

struct AccountInfoStaticCellView: View {

    let value: String
    let image: Image
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            AppTextFieldStaticView(value: value, leftImage: image)
        }
    }
}

#Preview {
    VStack {
        ScrollView {
            DropDownButtonView(title: "Test", openedView: AccountInfoCellView(value: .constant("test"), image: Image(systemName: "sofa"), placeHolder: "Placeholder"))
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()
    .background(Color.yellow)
}
