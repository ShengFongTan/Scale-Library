//
//  PageView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 24/9/23.
//

import SwiftUI

struct ModelKitsView: View {
    let device = UIDevice.current.model
    @State private var orientation = UIDevice.current.orientation
    
    var data: [Int] = Array(1...20)
    
    @Namespace var modelNamespace
    @State var showDetail: Bool = false
    @State var selectedElement: Int = 0
    
    var body: some View {
        
        
        NavigationStack {
            ZStack {
                List {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: device == "iPhone" && orientation.isPortrait ? UIScreen.main.bounds.width : 300, maximum: .infinity))]
                    ) {
                        ForEach(data.indices, id: \.self) { index in
                            ModelCard(modelNamespace: modelNamespace, index: index)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        selectedElement = index
                                        showDetail.toggle()
                                    }
                                }
                        }
                    }
                    .listRowInsets(EdgeInsets()) /// Remove list padding as ModelCard has its own padding.
                    .clearListItem()
                }
                .listStyle(PlainListStyle())
                
                if showDetail {
                    ModelKitDetailedView(modelNamespace: modelNamespace, index: $selectedElement, showDetail: $showDetail)
                        .zIndex(1)
                }
            }
            .navigationTitle(showDetail ? "" : "Model Kits")
            //.navigationBarBackButtonHidden(showDetail ? true : false)
            .toolbar(showDetail ? .hidden : .visible)
        }
        .detectOrientation($orientation)
    }
}

#Preview {
    ModelKitsView()
}
