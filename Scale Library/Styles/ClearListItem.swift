//
//  ClearListItem.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 6/10/23.
//

import SwiftUI

struct ClearListItem: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
}

extension View {
    func clearListItem() -> some View {
        modifier(ClearListItem())
    }
}
