//
//  LaunchScreenView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State private var isAnimating: Bool = false
    
    private let timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            background
            logo
        }
        .onReceive(timer) { input in
            withAnimation() {
                isAnimating.toggle()
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

private extension LaunchScreenView {
    var background: some View {
        Color("launch-screen-background")
            .edgesIgnoringSafeArea(.all)
    }
    
    var logo: some View {
        Image("logo")
            .scaleEffect(isAnimating ? 1.5 : 1)
    }
}
