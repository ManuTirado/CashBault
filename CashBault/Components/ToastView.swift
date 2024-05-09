//
//  ToastView.swift
//  CashBault
//
//  Created by manueltirado on 9/5/24.
//

import SwiftUI

struct ToastView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .modifier(TextModifier(size: 18, weight: .regular, color: Asset.Colors.primaryColor.swiftUIColor))
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.black.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct ToastModifier: ViewModifier {
    
    @Binding var toast: Toast?
    @State private var toastAux: Toast?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if let toastAux {
                    ToastView(text: toastAux.text)
                        .animation(.easeInOut, value: toastAux)
                }
            }
            .transition(.opacity)
            .animation(.easeInOut, value: toastAux)
            .onChange(of: toast) { _, _ in
                showToast()
            }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        toastAux = toast
        guard let toastAux else { return }
        
        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        if toastAux.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toastAux.duration, execute: task)
        }
        
        self.toast = nil
    }
    
    private func dismissToast() {
        toastAux = nil
        workItem?.cancel()
        workItem = nil
    }
}

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}

struct Toast: Equatable, Identifiable {
    var id: String {
        "\(text)\(duration)"
    }
    let text: String
    let duration: Double = 1.5
    
    init(_ text: String) {
        self.text = text
    }
}

#Preview {
    ToastView(text: "Testestes te esttest")
}
