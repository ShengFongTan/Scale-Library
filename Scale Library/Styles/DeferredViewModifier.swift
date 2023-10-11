//
//  DeferredViewModifier.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 5/10/23.
//

import SwiftUI

private struct DeferredViewModifier: ViewModifier {
    let threshold: Double = 0.5
    
    func body(content: Content) -> some View {
        _content(content)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + threshold) {
                    withAnimation(.easeInOut) {
                        self.shouldRender = true
                    }
                }
            }
    }
    
    @ViewBuilder
    private func _content(_ content: Content) -> some View {
        if shouldRender {
            content
        } else {
            content
                .hidden()
        }
    }
    
    @State
    private var shouldRender = false
}

extension View {
    func deferredRendering() -> some View {
        modifier(DeferredViewModifier())
    }
}
