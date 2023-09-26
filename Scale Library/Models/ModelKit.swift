//
//  ModelKit.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import Foundation
import SwiftData

@Model
final class ModelKit {
    var name: String
    var category: String
    var scale: String
    var brand: String
    
    init(name: String, category: String, scale: String, brand: String) {
        self.name = name
        self.category = category
        self.scale = scale
        self.brand = brand
    }
}
