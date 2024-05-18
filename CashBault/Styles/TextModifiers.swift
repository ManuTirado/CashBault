//
//  TextModifiers.swift
//  CashBault
//
//  Created by manueltirado on 30/4/24.
//

import Foundation
import SwiftUI

struct TextModifier: ViewModifier {
    
    let size: CGFloat
    let weight: Font.Weight
    var design: Font.Design = .default
    var color: Color = .black
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
            .foregroundStyle(color)
    }
}
