//
//  PageView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 24/9/23.
//

import SwiftUI

struct ModelKitsView: View {
    private let device = UIDevice.current.model
    @State private var orientation = UIDevice.current.orientation
    
    private var data: [Int] = Array(1...20)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("HomeBackground")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: device == "iPhone" && orientation.isPortrait ? UIScreen.main.bounds.width : 200, maximum: .infinity))],
                        spacing: 30
                    ) {
                        ForEach(data, id: \.self) { number in
                            NavigationLink(destination: ModelKitDetailedView()) {
                                ModelsCard()
                            }
                            .modifier(.clearNavLinkStyle)
                        }
                    }
                    .padding()
                }
                .detectOrientation($orientation)
            }
            .navigationTitle("Model Kits")
        }
    }
}

#Preview {
    NavigationStack {
        ModelKitsView()
    }
}
