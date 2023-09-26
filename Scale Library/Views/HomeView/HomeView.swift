//
//  ContentView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    
    var body: some View {
        
        VStack {
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 10) {
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                    Text("Hello, world!")
                }
            })
        }
        .padding()
        .onAppear {
            /// Simulate retrieving data. delay of 5 seconds before dismissing launch screen
            DispatchQueue
                .main
                .asyncAfter(deadline: .now() + 3) {
                    launchScreenManager.dismiss()
                }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LaunchScreenManager())
}
