//
//  AppNavigationBar.swift
//  CashBault
//
//  Created by manueltirado on 3/5/24.
//

import SwiftUI

struct AppNavigationBarModifier<LeftView, CentralView, RightView>: ViewModifier where LeftView: View, CentralView: View, RightView: View {
    var customLeftContent: () -> LeftView
    var customCenterContent: () -> CentralView
    var customRightContent: () -> RightView
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            Group {
                HStack {
                    Color.clear
                        .overlay(customLeftContent(), alignment: .center)
                        .frame(width: 60)
                    Color.clear
                        .overlay(customCenterContent(), alignment: .center)
                    Color.clear
                        .overlay(customRightContent(), alignment: .center)
                        .frame(width: 60)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                
                Rectangle()
                    .fill(.black.opacity(0.5))
                    .frame(height: 1)
                    
            }
            .background(Asset.Colors.background.swiftUIColor)
            content
                .navigationBarHidden(true)
                .navigationTitle("")
            Spacer(minLength: 0)
        }
    }
}

extension View {
    func customNavigationBar<LeftView: View, CentralView: View, RightView: View>(
        customLeftContent: @escaping () -> LeftView? = { EmptyView() },
        customCenterContent: @escaping () -> CentralView? = { EmptyView() },
        customRightContent: @escaping () -> RightView? = { EmptyView() }
    ) -> some View {
        self.modifier(AppNavigationBarModifier(
            customLeftContent: customLeftContent,
            customCenterContent: customCenterContent,
            customRightContent: customRightContent
        ))
    }
}

#Preview {
    NavigationView {
        VStack {
            Text("Hello, World!")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Constants.backgroundColorGradient)
        .customNavigationBar(
            customLeftContent: {
                Image(systemName: "arrow.left")
            },
            customCenterContent: {
                Text("Hello, World!")
            },
            customRightContent: {
                Image(systemName: "gear")
            }
        )
    }
}
