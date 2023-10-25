//
//  HomeViewModel.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 25/10/23.
//

import Foundation
import SwiftUI
import SwiftData

extension HomeView {
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        var showErrorAlert = false
        var errorAlertMessage = ""
        var plannedProjectsCount = 0
        var modelKitsCount = 0
        var modelKitsTotalPrice = 0
        var accessoriesCount = 0
        var paintsCount = 0
        
        init(
            modelContext: ModelContext
        ) {
            self.modelContext = modelContext
            
            //getModelKitsCount()
        }
        
        func getModelKitsCount() {
            do {
                let descriptor = FetchDescriptor<ModelKit>()
                modelKitsCount = try modelContext.fetchCount(descriptor)
            } catch {
                errorAlertMessage = "Something went wrong, please restart the app"
                showErrorAlert = true
            }
        }
    }
}
