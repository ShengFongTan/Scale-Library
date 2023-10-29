//
//  ModelKitDetailView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 9/10/23.
//

import SwiftUI
import SwiftData

/*
 Displays all information about a model kit.
 
 Displays basic information of a model kit:
    - Image (In the background)
    - Title
    - Description
    - Scale
    - Brand
    - Category
 
 The elements which stores the information above are linked to their
 counterparts in ModelKitCard used in ModelKitsView via the .matchedGeometryEffect modifier.
 
 Displays other information about the model kit:
    - Date bought
    - Price
    - Planned project
*/

struct ModelKitDetailView: View {
    @Environment(Observables.self) var observables: Observables
    
    // For matched geometry animation
    var modelNamespace: Namespace.ID
    
    // Binding to control visibility of ModelKitDetailView
    @Binding var showDetail: Bool
    
    // State to control visibility of ModelKitFormView
    @State private var showEditModelKit = false
    
    @State var disableGeomtryEffect = false
    
    @State var viewModel: ViewModel
    var modelContext: ModelContext
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color(.white)
                    .ignoresSafeArea()
                
                ScrollView {
                    ZStack {
                        // Blue gradient background
                        LinearGradient(
                            colors: [Color(.twitterBlue), Color(.mediumBlue)],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .frame(height: 800)
                        .offset(y: -400) // If no offset, background colour will show if user scroll up.
                        .standardShadow()
                        
                        // Model kit information section
                        VStack(spacing: 30) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(observables.selectedModelKit!.title)
                                    .font(.title2.weight(.bold))
                                    .matchedGeometryEffect(id: !disableGeomtryEffect ? "title\(observables.selectedModelKit!.id)" : "", in: modelNamespace)
                                Text(observables.selectedModelKit!.shortDescription)
                                    .font(.footnote)
                                    .matchedGeometryEffect(id: !disableGeomtryEffect ? "description\(observables.selectedModelKit!.id)" : "", in: modelNamespace)
                                HStack(alignment: .center, spacing: 6) {
                                    ItemTag(text: "1/48", theme: Theme.FieldBlue)
                                        .lightShadow()
                                        .matchedGeometryEffect(id: !disableGeomtryEffect ? "scale\(observables.selectedModelKit!.id)" : "", in: modelNamespace)
                                    ItemTag(text: "Tamiya", theme: Theme.TwitterBlue)
                                        .lightShadow()
                                        .matchedGeometryEffect(id: !disableGeomtryEffect ? "brand\(observables.selectedModelKit!.id)" : "", in: modelNamespace)
                                    ItemTag(text: "Aircraft", theme: Theme.Maroon)
                                        .lightShadow()
                                        .matchedGeometryEffect(id: !disableGeomtryEffect ? "category\(observables.selectedModelKit!.id)" : "", in: modelNamespace)
                                }
                            }
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            /*
                             For some reason adding the matchedGeometryEffect modifier(must include the ternary statement)
                             below solves the laggy animation caused by the matchedGeometryEffect modifiers in the model
                             kit information section above.
                            */
                            .matchedGeometryEffect(id: !disableGeomtryEffect ? "Dummy" : "", in: modelNamespace)
                            
                            VStack(spacing: 10) {
                                // Model kit image
                                Group {
                                    if (observables.selectedModelKit!.image != nil) {
                                        Image(uiImage: UIImage(data: observables.selectedModelKit!.image!)!)
                                            .resizable()
                                            .scaledToFit()
                                            .matchedGeometryEffect(id: !disableGeomtryEffect ? "image\(observables.selectedModelKit!.id)" : "", in: modelNamespace)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .matchedGeometryEffect(id: !disableGeomtryEffect ? "roundendedCornersMask\(observables.selectedModelKit!.id)" : "", in: modelNamespace)
                                    } else {
                                        ZStack {
                                            Color.white
                                            Image(systemName: "photo")
                                                .resizable()
                                                .opacity(0.3)
                                                .scaledToFit()
                                                .padding()
                                                .matchedGeometryEffect(id: !disableGeomtryEffect ? "image\(observables.selectedModelKit!.id)" : "", in: modelNamespace)
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .matchedGeometryEffect(id: !disableGeomtryEffect ? "roundendedCornersMask\(observables.selectedModelKit!.id)" : "", in: modelNamespace)
                                    }
                                }
                                .standardShadow()
                                
                                // Bought date and price
                                HStack(alignment: .center, spacing: 4) {
                                    Text("Bought on")
                                        .font(.caption)
                                    Text(observables.selectedModelKit!.date, format: .dateTime.day().month().year())
                                        .font(.caption)
                                        .bold()
                                    Spacer()
                                    Text(formatCurrency(amount: observables.selectedModelKit!.price))
                                        .fontWeight(.bold)
                                }
                                .deferredRendering()
                                
                                Divider().deferredRendering()
                            }
                            
                            // Planned project
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Planned project")
                                    .font(.headline)
                                VStack {
                                    HStack(alignment: .top) {
                                        Image("f-35a")
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 70, height: 70)
                                            .padding(.trailing, 10)
                                        VStack(alignment: .leading, spacing: 12) {
                                            Text("F-35A")
                                                .font(.title3.weight(.bold))
                                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                                .font(.footnote)
                                        }
                                        Spacer()
                                    }
                                    HStack(alignment: .center, spacing: 6) {
                                        ItemTag(text: "1/48", theme: Theme.FieldBlue)
                                        ItemTag(text: "Tamiya", theme: Theme.TwitterBlue)
                                        ItemTag(text: "Aircraft", theme: Theme.Maroon)
                                    }
                                }
                                .padding(20)
                                .background(
                                    Rectangle()
                                        .fill(.thickMaterial)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .lightShadow()
                            }
                            .padding(.bottom, 50)
                            .deferredRendering()
                        }
                        .padding(.top, 60)
                        .padding(.top, geometry.safeAreaInsets.top) // Provide padding for top safe area when Portrait
                        .padding(.leading, geometry.safeAreaInsets.leading) // Provide padding for safe area when horizontal
                        .padding(.trailing, geometry.safeAreaInsets.trailing) // Provide padding for safe area when horizontal
                        .padding()
                    }
                }
                .scrollIndicators(.hidden)
                .ignoresSafeArea()
                
                // Close and menu buttons
                HStack {
                    Button {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showDetail.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.body.weight(.bold))
                            .foregroundStyle(.secondary)
                            .padding(6)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .clearNavLink()
                    
                    Spacer()
                    
                    Menu {
                        Button("Edit", systemImage: "pencil", action: {showEditModelKit = true})
                        Button("Delete", systemImage: "xmark.bin", role: .destructive, action: {
                            withAnimation {
                                let result = viewModel.deleteModelKit(modelKit: observables.selectedModelKit!)
                                if result {
                                    /*
                                     Prevents strange geomtryEffect animation after delete by removing id in all
                                     matchedGeometryEffect modifiers using ternary statement to check disableGeomtryEffect value.
                                    */
                                    disableGeomtryEffect = true
                                    showDetail.toggle()
                                }
                            }
                        })
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.body.weight(.bold))
                            .foregroundStyle(Color(.darkGrey))
                            .padding(10)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                }
                .padding(.leading, 15)
                .padding(.trailing, 10)
                .padding(.top)
            }
            .fullScreenCover(isPresented: $showEditModelKit) {
                ModelKitFormView(modelContext: modelContext, selectedModelKit: observables.selectedModelKit!)
            }
            .alert(viewModel.errorAlertMessage, isPresented: $viewModel.showErrorAlert) {}
        }
    }
    
    init(modelContext: ModelContext, modelNamespace: Namespace.ID, showDetail: Binding<Bool>) {
        self.modelContext = modelContext
        self.modelNamespace = modelNamespace
        self._showDetail = showDetail
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}

#Preview {
    @Namespace var modelNamespace
    let preview = PreviewContainer([ModelKit.self])
    return ModelKitDetailView(
        modelContext: preview.container.mainContext,
        modelNamespace: modelNamespace,
        showDetail: .constant(true)
    )
    .modelContainer(preview.container)
    .environment(Observables(selectedModelKit: ModelKit.sampleData[0]))
}
