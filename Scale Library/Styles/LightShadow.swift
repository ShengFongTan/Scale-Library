//
//  LightShadow.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 6/10/23.
//

import SwiftUI

struct LightShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.1), radius: 3)
    }
}

extension View {
    func lightShadow() -> some View {
        modifier(LightShadow())
    }
}
