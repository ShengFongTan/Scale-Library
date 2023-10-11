//
//  PageView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 24/9/23.
//

import SwiftUI
import SwiftData

struct ModelKitsView: View {
    let device = UIDevice.current.model
    @State private var orientation = UIDevice.current.orientation
    @Environment(\.modelContext) private var context
    @Query private var modelKits: [ModelKit]
    
    @State private var showAddModelKit = false
    @State private var showEditModelKit = false
    
    @Namespace var modelNamespace
    @State var showDetail: Bool = false
    @State var selectedModelKit: ModelKit = ModelKit.sampleData[0]
    
    var body: some View {
        NavigationStack {
            ZStack {
                if modelKits.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Model Kits", systemImage: "shippingbox")
                    }, description: {
                        Text("Start adding model kits to your library.")
                    }, actions: {
                        Button("Add new kit", systemImage: "plus", action: {showAddModelKit = true})
                    })
                    .offset(y: -60)
                } else {
                    ScrollView {
                        LazyVGrid(
                            columns: [GridItem(.adaptive(minimum: device == "iPhone" && orientation.isPortrait ? UIScreen.main.bounds.width : 300, maximum: .infinity))],
                            spacing: 20
                        ) {
                            ForEach(modelKits, id: \.id) { modelKit in
                                ModelCard(modelNamespace: modelNamespace, modelKit: modelKit)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                            selectedModelKit = modelKit
                                            showDetail.toggle()
                                        }
                                    }
                                    .contextMenu {
                                        Button {
                                            selectedModelKit = modelKit
                                            showEditModelKit = true
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        Button {
                                            context.delete(modelKit)
                                            do {
                                                try context.save()
                                            } catch {
                                                print(error.localizedDescription)
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "xmark.bin")
                                        }
                                    }
                            }
                        }
                        .padding()
                        //.listRowInsets(EdgeInsets()) /// Remove list padding as ModelCard has its own padding.
                        //.clearListItem()
                    }
                    //.listStyle(.plain)
                }
                
                if showDetail {
                    ModelKitDetailView(modelNamespace: modelNamespace, modelKit: $selectedModelKit, showDetail: $showDetail)
                        .zIndex(1)
                }
            }
            .navigationTitle(showDetail ? "" : "Model Kits")
            .toolbar(showDetail ? .hidden : .visible)
            .toolbar {
                Button(action: {
                    showAddModelKit = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .fullScreenCover(isPresented: $showAddModelKit) {
                NewModelKitSheet()
            }
            .fullScreenCover(isPresented: $showEditModelKit) {
                EditModelKitSheet(modelKit: $selectedModelKit)
            }
        }
        .detectOrientation($orientation)
    }
}

#Preview {
    ModelKitsView()
}
