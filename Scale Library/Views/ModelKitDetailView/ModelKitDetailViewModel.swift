//
//  ModelKitDetailViewModel.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 20/10/23.
//

import Foundation
import SwiftData

extension ModelKitDetailView {
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        var showErrorAlert = false
        var errorAlertMessage = ""
        
        init(
            modelContext: ModelContext
        ) {
            self.modelContext = modelContext
        }
        
        func deleteModelKit(modelKit: ModelKit) -> Bool {
            do {
                modelContext.delete(modelKit)
                try modelContext.save()
                return true
            } catch {
                errorAlertMessage = "Failed to delete, please try again"
                showErrorAlert = true
                return false
            }
        }
    }
}
