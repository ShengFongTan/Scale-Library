//
//  LaunchScreenView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @State private var firstPhaseIsAnimating: Bool = false
    @State private var secondPhaseIsAnimating: Bool = false
    
    var background: some View {
        Color("launch-screen-background")
            .edgesIgnoringSafeArea(.all)
    }
    
    var logo: some View {
        Image("logo")
            .scaleEffect(firstPhaseIsAnimating ? 1.5 : 1)
    }
    
    /// Timer to toggle the animations in intervals of specified value in seconds
    private let timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            background
            logo
        }
        /**
         Every timer interval, if launch screen state is first, will cause icon to bob.
         if state is second, will cause launch screen do fade out.
         */
        .onReceive(timer) { input in
            switch launchScreenManager.state{
            case .first:
                withAnimation(.spring()) {
                    firstPhaseIsAnimating.toggle()
                }
            case .second:
                withAnimation(.easeInOut) {
                    secondPhaseIsAnimating = true
                }
            default: break
            }
        }
        .opacity(secondPhaseIsAnimating ? 0 : 1)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenManager())
    }
}
