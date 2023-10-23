//
//  ModelKitFormViewModel.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 13/10/23.
//

import Foundation
import SwiftUI
import SwiftData
import PhotosUI

extension ModelKitFormView {
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        var validator = ModelKitFormValidator()
        var modelKit: ModelKit // Model used for editing in the form
        var selectedModelKit: ModelKit? // Original model kit selected for editing.
        
        // Initialiser for adding new model
        init(
            modelContext: ModelContext,
            modelKit: ModelKit = ModelKit.emptyModelKit
        ) {
            self.modelContext = modelContext
            self.modelKit = modelKit
        }
        
        // Initialiser for editing selected model
        init(
            modelContext: ModelContext,
            selectedModelKit: ModelKit
        ) {
            self.modelContext = modelContext
            self.selectedModelKit = selectedModelKit
            
            // Create model kit with data from the original.
            self.modelKit = ModelKit(
                image: selectedModelKit.image,
                title: selectedModelKit.title,
                shortDescription: selectedModelKit.shortDescription,
                price: selectedModelKit.price,
                date: selectedModelKit.date
            )
        }
        
        // Start of photo picker stuff
        enum ImageState {
            case empty
            case loading(Progress)
            case success(Data)
            case failure(Error)
        }
        
        private(set) var imageState: ImageState = .empty
        
        /*
         Stores selected image
         If selected image changes, automatically updates the model
        */
        var imageSelection: PhotosPickerItem? = nil {
            didSet {
                if let imageSelection {
                    //var selectedPhotoData = await convertImageToData(from: imageSelection)
                    //modelKit.image = selectedPhotoData
                    let progress = loadTransferable(from: imageSelection)
                    self.imageState = .loading(progress)
                } else {
                    self.imageState = .empty
                }
            }
        }
        
//        private func convertImageToData(from imageSelection: PhotosPickerItem) async -> Data {
//            return try! await imageSelection.loadTransferable(type: Data.self)!
//        }
        
        private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
            return imageSelection.loadTransferable(type: Data.self) { result in
                DispatchQueue.main.async {
                    guard imageSelection == self.imageSelection else {
                        print("Failed to get the selected item.")
                        return
                    }
                    switch result {
                    case .success(let imageData?):
                        self.imageState = .success(imageData)
                        self.modelKit.image = imageData
                    case .success(nil):
                        self.imageState = .empty
                    case .failure(let error):
                        self.imageState = .failure(error)
                    }
                }
            }
        }
        
        func removeImage() {
            imageSelection = nil
            modelKit.image = nil
        }
        // End of photopicker stuff
        
        // Start of form stuff
        var showErrorAlert = false
        var showErrorHint = false
        var errorDescription = ""
        private(set) var error: ModelKitFormValidator.FormError?
        
        func addNewModelKit() -> Bool {
            do {
                try validator.validate(modelKit: modelKit)
                showErrorHint = false
                modelContext.insert(modelKit)
                
                do {
                    try modelContext.save()
                    return true
                } catch {
                    // Store context saving error to display in alert.
                    if let contextSavingError = error as? ModelKitFormValidator.CreateValidatorError {
                        self.error = .contextSaving(error: contextSavingError)
                    }
                    return false
                }
            } catch {
                showErrorHint = true
                showErrorAlert = true
                
                // Store validation error to display in alert.
                if let validationError = error as? ModelKitFormValidator.CreateValidatorError {
                    self.error = .validation(error: validationError)
                }
                
                // Retrieve error description from validator to display as hint.
                if case .validation(let err) = self.error,
                   let errorDescription = err.errorDescription {
                    self.errorDescription = errorDescription
                }
                return false
            }
        }
        
        func editModelKit() -> Bool {
            do {
                try validator.validate(modelKit: modelKit)
                showErrorHint = false
                
                // Since validation no error, can replace original with new value.
                // Can force unwrap since selectedModelKit will always have a model during edit.
                selectedModelKit!.image = modelKit.image
                selectedModelKit!.title = modelKit.title
                selectedModelKit!.shortDescription = modelKit.shortDescription
                selectedModelKit!.price = modelKit.price
                selectedModelKit!.date = modelKit.date
                
                do {
                    try modelContext.save()
                    return true
                } catch {
                    // Store context saving error to display in alert.
                    if let contextSavingError = error as? ModelKitFormValidator.CreateValidatorError {
                        self.error = .contextSaving(error: contextSavingError)
                    }
                    return false
                }
            } catch {
                showErrorHint = true
                showErrorAlert = true
                
                // Store validation error to display in alert.
                if let validationError = error as? ModelKitFormValidator.CreateValidatorError {
                    self.error = .validation(error: validationError)
                }
                
                // Retrieve error description from validator to display as hint.
                if case .validation(let err) = self.error,
                   let errorDescription = err.errorDescription {
                    self.errorDescription = errorDescription
                }
                return false
            }
        }
        // End of form stuff
    }
}
