//
//  NavigationCardStyle.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 25/9/23.
//

import SwiftUI

//struct NavigationCardStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .foregroundStyle(.black)
//            .tint(Color.clear)
//    }
//}

struct ClearNavLink: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.black)
            .tint(Color.clear)
    }
}

extension View {
    func clearNavLink() -> some View {
        modifier(ClearNavLink())
    }
}
