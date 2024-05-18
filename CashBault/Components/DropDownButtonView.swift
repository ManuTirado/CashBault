//
//  DropDownButtonView.swift
//  CashBault
//
//  Created by manueltirado on 13/5/24.
//

import SwiftUI

struct DropDownButtonView<Content: View>: View {
    @State private var isOpened: Bool = false
    @State private var isOpenedAux: Bool = false
    let title: String
    let openedView: Content
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .modifier(TextModifier(size: 18, weight: .heavy, color: Asset.Colors.primaryColor.swiftUIColor))
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundStyle(Asset.Colors.primaryColor.swiftUIColor)
                    .rotationEffect(.degrees(isOpenedAux ? -180 : 0))
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                if isOpened {
                    withAnimation {
                        isOpenedAux = false
                    } completion: {
                        isOpened = isOpenedAux
                    }
                } else {
                    isOpened = true
                }
            }
            if isOpened {
                Rectangle()
                    .fill(Asset.Colors.secondaryColor.swiftUIColor)
                    .frame(height: 1)
            }
            if isOpened {
                openedView
                .frame(maxWidth: .infinity)
                .frame(height: isOpenedAux ? nil : 0)
                
                .clipped()
                .onAppear {
                    withAnimation {
                        isOpenedAux = isOpened
                    }
                }
            }
        }
        .background(Asset.Colors.background.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Asset.Colors.secondaryColor.swiftUIColor, lineWidth: 1)
        }
        .padding(1)
    }
}

#Preview {
    DropDownButtonView(title: "Test", openedView: VStack { Text("Test").frame(height: 50) })
}
