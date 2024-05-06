//
//  CircleIconButtonView.swift
//  CashBault
//
//  Created by manueltirado on 6/5/24.
//

import SwiftUI

struct CircleIconButtonView: View {
    
    let icon: Image
    var text: String? = nil
    var textColor: Color = .white
    var foregroundColor: Color = .white
    var backgroundColor: Color = .lightBackground
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Button {
                    action()
                } label: {
                    icon
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(foregroundColor)
                        .padding(15)
                        .background(backgroundColor)
                        .background(Circle().stroke(Asset.Colors.secondaryColor.swiftUIColor, lineWidth: 2))
                        .clipShape(Circle())
                        .padding(2)
                }
                .contentShape(Rectangle())
            }
            if let text {
                Text(text)
                    .modifier(TextModifier(size: 14, weight: .bold, color: textColor))
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    CircleIconButtonView(icon: Image(systemName: "plus"), text: "Add Test", textColor: .darkBackground, foregroundColor: .white, backgroundColor: .cyan, action: {} )
}
