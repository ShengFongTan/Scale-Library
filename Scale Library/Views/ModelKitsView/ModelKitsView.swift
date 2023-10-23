//
//  PageView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 24/9/23.
//

import SwiftUI
import SwiftData

/*
 Main page for model kits where user can perform model kits specific tasks.
 - Displays all model kits in a grid view.
 - Add new model kit by tapping on the 􀅼 button on the toolbar or the 'Add new kit' button(Only when no model kits).
 - View model kits detail by tapping on a model kit.
 - Edit/delete a model kit by activating context menu on a model kit.
*/

struct ModelKitsView: View {
    @Environment(Observables.self) var observables: Observables
    
    // For managing gridview column sizes
    let device = UIDevice.current.model
    @State var orientation = UIDevice.current.orientation
    
    // States to control form visibility
    @State var showAddModelKit = false
    @State var showEditModelKit = false
    
    // For matched geometry animation when viewing model kit details
    @Namespace var modelNamespace
    
    // State to control visibility of ModelKitDetailView
    @State var showDetail: Bool = false
    
    @State var viewModel: ViewModel
    var modelContext: ModelContext
    
    // Realtime list of all model kits
    @Query var modelKits: [ModelKit]
    
    var body: some View {
        NavigationStack {
            ZStack {
                if modelKits.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Model Kits", systemImage: "shippingbox")
                    }, description: {
                        Text("Start adding model kits to your library.")
                    }, actions: {
                        Button("Add new kit", systemImage: "plus", action: {showAddModelKit.toggle()})
                    })
                    .offset(y: -20)
                } else {
                    ScrollView {
                        LazyVGrid(
                            // Limit width of column if device is iPhone and portrait
                            columns: [GridItem(.adaptive(minimum: device == "iPhone" && orientation.isPortrait ? UIScreen.main.bounds.width : 300, maximum: .infinity))],
                            spacing: 20
                        ) {
                            ForEach(modelKits, id: \.id) { modelKit in
                                ModelKitCard(modelNamespace: modelNamespace, modelKit: modelKit)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                            observables.selectedModelKit = modelKit
                                            showDetail.toggle()
                                        }
                                    }
                                    .contextMenu {
                                        Button {
                                            observables.selectedModelKit = modelKit
                                            showEditModelKit.toggle()
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        Button {
                                            withAnimation {
                                                viewModel.deleteModelKit(modelKit: modelKit)
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "xmark.bin")
                                        }
                                    }
                                    .padding()
                            }
                        }
                    }
                }
                
                if showDetail {
                    ModelKitDetailView(modelContext: modelContext, modelNamespace: modelNamespace, showDetail: $showDetail)
                        .zIndex(1) // Have to include if not selected ModelKitCard will go underneath other cards during animation.
                }
            }
            // Hides title & toolbar as it will remain visible even after ModelKitDetailView is visible
            .toolbar(showDetail ? .hidden : .visible)
            .navigationTitle("Model Kits")
            .toolbar {
                Button(action: {
                    showAddModelKit.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
            .fullScreenCover(isPresented: $showAddModelKit) {
                ModelKitFormView(modelContext: modelContext)
            }
            .fullScreenCover(isPresented: $showEditModelKit) {
                ModelKitFormView(modelContext: modelContext, selectedModelKit: observables.selectedModelKit!)
            }
        }
        .detectOrientation($orientation)
        .alert(viewModel.errorAlertMessage, isPresented: $viewModel.showErrorAlert) {}
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}

#Preview("No model kits") {
    let preview = PreviewContainer([ModelKit.self])
    return ModelKitsView(modelContext: preview.container.mainContext)
        .modelContainer(preview.container)
        .environment(Observables())
}

#Preview("Have model kits") {
    let preview = PreviewContainer([ModelKit.self])
    preview.add(items: ModelKit.sampleData)
    return ModelKitsView(modelContext: preview.container.mainContext)
        .modelContainer(preview.container)
        .environment(Observables())
}
