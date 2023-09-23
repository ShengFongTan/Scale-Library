//
//  LaunchScreenManager.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import Foundation

enum LaunchScreenPhase {
    case first /// Icon bobbing animation
    case second /// Opacity fade animation
    case completed /// Loading done, hides launch screen
}

final class LaunchScreenManager: ObservableObject {
    /// Defaults state to first animation
    @Published private(set) var state: LaunchScreenPhase = .first
    
    func dismiss() {
        /// Triggers second animation
        self.state = .second
        
        /// Delay of 1 second to show second animation, if not launch screen instantly hides
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.state = .completed
        }
    }
}
