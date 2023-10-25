//
//  ModelKitsViewModel.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 12/10/23.
//
import Foundation
import SwiftUI
import SwiftData

extension ModelKitsView {
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        var modelKitsList: [ModelKit]
        var showErrorAlert = false
        var errorAlertMessage = ""
        
        init(
            modelContext: ModelContext,
            modelKitsList: [ModelKit] = [ModelKit]()
        ) {
            self.modelContext = modelContext
            self.modelKitsList = modelKitsList
        }
        
        func fetchModelKits() {
            do {
                let descriptor = FetchDescriptor<ModelKit>(sortBy: [SortDescriptor(\.title)])
                modelKitsList = try modelContext.fetch(descriptor)
            } catch {
                errorAlertMessage = "Failed to retrieve model kits, please restart the app"
                showErrorAlert = true
            }
        }
        
        func deleteModelKit(modelKit: ModelKit) {
            do {
                modelContext.delete(modelKit)
                try modelContext.save()
                fetchModelKits()
            } catch {
                errorAlertMessage = "Failed to delete, please try again"
                showErrorAlert = true
            }
        }
    }
}
