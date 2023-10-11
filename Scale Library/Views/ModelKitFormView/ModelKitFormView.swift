//
//  ModelKitEditView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 7/10/23.
//

import SwiftUI
import PhotosUI

struct ModelKitFormView: View {
    @ObservedObject var viewModel: PhotoPickerViewModel = PhotoPickerViewModel()
    @FocusState private var isInputActive: Bool
    @Binding var modelKit: ModelKit
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                List {
                    Section() {
                        PhotosPicker (
                            selection: $viewModel.imageSelection,
                            
                            // Enable the app to dynamically respond to user adjustments.
                            matching: .images,
                            preferredItemEncoding: .current,
                            photoLibrary: .shared()
                        ) {
                            Group {
                                switch viewModel.imageState {
                                case.success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .standardShadow()
                                case.loading:
                                    ProgressView()
                                case.empty:
                                    Image(systemName: "photo")
                                        .font(.system(size: 150))
                                        .opacity(0.2)
                                        .frame(maxWidth: .infinity, maxHeight: 250)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                case .failure:
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .frame(height: 250)
                        .clearListItem()
                    } footer: {
                        VStack {
                            Text("Tap to select image")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    Section() {
                        TextField("Title", text: $modelKit.title)
                            .onSubmit {
                                isInputActive = false
                            }
                            .submitLabel(.done)
                            .focused($isInputActive)
                        
                        TextField("Description", text: $modelKit.shortDescription)
                            .onSubmit {
                                isInputActive = false
                            }
                            .submitLabel(.done)
                            .focused($isInputActive)
                        
                        TextField("Price", text: .constant(""))
                            .onSubmit {
                                isInputActive = false
                            }
                            .submitLabel(.done)
                            .focused($isInputActive)
                        
                        DatePicker("Bought on", selection: .constant(.now), displayedComponents: .date)
                    } header: {
                        Text("Basic info")
                    }
                    
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
            }
        }
    }
}

#Preview {
    ModelKitFormView(modelKit: .constant(ModelKit.sampleData[0]))
}
