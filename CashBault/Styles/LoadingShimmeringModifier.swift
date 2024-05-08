//
//  LoadingShimmeringModifier.swift
//  CashBault
//
//  Created by manueltirado on 8/5/24.
//

import SwiftUI

struct LoadingShimmeringModifier: ViewModifier {
    
    @Binding var isLoading: Bool
    @State private var animationToggle: Bool = false
    
    func body(content: Content) -> some View {
        if isLoading {
            content
                .redacted(reason:.placeholder)
                .foregroundStyle(
                    LinearGradient(colors: [.black, .white],
                                   startPoint: .topLeading,
                                   endPoint: animationToggle ? .topLeading : .bottomTrailing)
                )
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                        animationToggle.toggle()
                    }
                }
        } else {
            content
        }
    }
}

struct LoadingShimmeringModifierV2: ViewModifier {
    
    @Binding var isLoading: Bool
    @State private var animationToggle: Bool = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isLoading ? 0 : 1)
            .overlay {
                if isLoading {
                    Rectangle()
                        .fill(
                            LinearGradient(colors: [.black, .white],
                                           startPoint: .topLeading,
                                           endPoint: animationToggle ? .bottomTrailing : .topLeading)
                        )
                        .mask(content)
                        .redacted(reason: .placeholder)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                animationToggle.toggle()
                            }
                        }
                }
            }
    }
}


#Preview {
    ZStack {
        Color.green.ignoresSafeArea()
        VStack {
            AccountCellView(account: Account.Mock1, isLoading: .constant(true))
//                .modifier(LoadingShimmeringModifier(isLoading: .constant(true)))
            
            Text("TestetsetTestetsetTestetsetTestetset")
                .modifier(TextModifier(size: 18, weight: .bold))
                .modifier(LoadingShimmeringModifier(isLoading: .constant(true)))
            Text("TestetsetTestetsetTestetsetTestetset")
                .modifier(TextModifier(size: 18, weight: .bold))
                .modifier(LoadingShimmeringModifierV2(isLoading: .constant(true)))
            Text("TestetsetTestetsetTestetsetTestetset")
                .modifier(LoadingShimmeringModifier(isLoading: .constant(true)))
                .modifier(TextModifier(size: 18, weight: .bold))
        }
        //        .modifier(LoadingShimmeringModifier(isLoading: .constant(true)))
    }
    
}
