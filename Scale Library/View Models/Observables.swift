//
//  Observables.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 22/10/23.
//

import Foundation

/*
 Global variables that are used across multiple views.
 Initialised in Scale_LibraryApp.
*/

@Observable
class Observables {
    // Refers to the specific model kit user has tapped on or selected in context menu.
    var selectedModelKit: ModelKit?
    
    init(
        selectedModelKit: ModelKit? = nil
    ) {
        self.selectedModelKit = selectedModelKit
    }
}
