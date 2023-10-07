//
//  StandardShadow.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 5/10/23.
//

import SwiftUI

struct StandardShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.3), radius: 5)
    }
}

extension View {
    func standardShadow() -> some View {
        modifier(StandardShadow())
    }
}
