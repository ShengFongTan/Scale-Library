//
//  ModelKitEditView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 7/10/23.
//

import SwiftUI
import PhotosUI
import SwiftData

/*
 ModelKitFormView allows users to add new model kit or edit exisitng model kit.
 In 'add' mode, form will be empty.
 In 'Edit' mode, form will be pre-filled with data of the selected model kit.
 The different modes are initialised based on the arguments passed into init.
*/

struct ModelKitFormView: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: ViewModel
    @FocusState private var isInputActive: Bool
    
    var action: String
    
    var body: some View {
        NavigationStack {
            Form {
                // Image section
                Section() {
                    if let imageData = viewModel.modelKit.image,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .listRowInsets(EdgeInsets())
                    }
                    
                    if viewModel.modelKit.image == nil {
                        PhotosPicker(
                            selection: $viewModel.imageSelection,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            Label("Add Image", systemImage: "photo")
                        }
                    }
                    
                    if viewModel.modelKit.image != nil {
                        Button(role: .destructive) {
                            withAnimation {
                                viewModel.imageSelection = nil
                                viewModel.modelKit.image = nil
                            }
                        } label: {
                            Label("Remove Image", systemImage: "xmark")
                                .foregroundStyle(.red)
                        }
                    }
                } footer: {
                    VStack {
                        Text("Tap to select image")
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Basic info section
                Section() {
                    TextField("Title", text: $viewModel.modelKit.title)
                        .onSubmit {
                            isInputActive = false
                        }
                        .submitLabel(.done)
                        .focused($isInputActive)
                    
                    TextField("Description", text: $viewModel.modelKit.shortDescription)
                        .onSubmit {
                            isInputActive = false
                        }
                        .submitLabel(.done)
                        .focused($isInputActive)
                    
                    TextField("Price", value: $viewModel.modelKit.price, format: .currency(code: "SGD"))
                        .onSubmit {
                            isInputActive = false
                        }
                        .submitLabel(.done)
                        .focused($isInputActive)
                    
                    DatePicker("Bought on", selection: $viewModel.modelKit.date, in: ...Date(), displayedComponents: .date)
                } header: {
                    Text("Basic info")
                } footer: {
                    viewModel.showErrorHint ? Text(viewModel.errorDescription).foregroundStyle(.red) : nil
                }
                
                // Details section
                Section() {
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Scale")
                            Divider()
                            Text("Brand")
                            Divider()
                            Text("Category")
                        }
                        .frame(width: 120)
                        VStack(alignment: .leading) {
                            ItemTag(text: "1/48", theme: Theme.FieldBlue)
                            Divider()
                            ItemTag(text: "Tamiya", theme: Theme.TwitterBlue)
                            Divider()
                            ItemTag(text: "Aircraft", theme: Theme.Maroon)
                        }
                    }
                } header: {
                    Text("Details")
                }
                
                // Planned project section
                Section() {
                    HStack {
                        Image("f-35a")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                            .padding(.trailing, 10)
                        Text("RSAF SH-60B Seahawk")
                    }
                } header: {
                    Text("Project")
                }
            }
            .navigationTitle("Model kit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    if self.action == "Add" {
                        Button("Add") {
                            viewModel.addNewModelKit() ? dismiss() : nil
                        }
                    } else if self.action == "Edit" {
                        Button("Save") {
                            viewModel.editModelKit() ? dismiss() : nil
                        }
                    }
                }
            }
            .alert(isPresented: $viewModel.showErrorAlert, error: viewModel.error) {}
        }
    }
    
    init(modelContext: ModelContext) {
        self.action = "Add"
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    init(modelContext: ModelContext, selectedModelKit: ModelKit) {
        self.action = "Edit"
        let viewModel = ViewModel(modelContext: modelContext, selectedModelKit: selectedModelKit)
        _viewModel = State(initialValue: viewModel)
    }
}

#Preview("Adding new model kit") {
    let preview = PreviewContainer([ModelKit.self])
    return ModelKitFormView(modelContext: preview.container.mainContext)
        .modelContainer(preview.container)
}

#Preview("Edit model kit") {
    let observables = Observables(selectedModelKit: ModelKit.sampleData[0])
    let preview = PreviewContainer([ModelKit.self])
    return ModelKitFormView(modelContext: preview.container.mainContext, selectedModelKit: observables.selectedModelKit!)
        .modelContainer(preview.container)
}
