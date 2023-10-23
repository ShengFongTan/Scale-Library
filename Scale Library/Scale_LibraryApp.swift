//
//  Scale_LibraryApp.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import SwiftUI
import SwiftData

/*
 Application's root where model container and environment objects
 are defined.
 
 Model Context is passed down to child views via init for their viewmodels.
*/

@main
struct Scale_LibraryApp: App {
    @State var observables: Observables = Observables()
    
    // Defining model container for all models
    let container: ModelContainer = {
        let schema = Schema([ModelKit.self])
        let container = try! ModelContainer(for: schema)
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(modelContext: container.mainContext)
            }
            // Passed into navigaiton stack so all views inside navigation stack can access.
            .environment(observables)
        }
        .modelContainer(container)
    }
}
