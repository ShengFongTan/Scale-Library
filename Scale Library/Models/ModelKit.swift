//
//  ModelKit.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import Foundation
import SwiftData

@Model
class ModelKit: Identifiable {
    @Attribute(.unique) var id: String = UUID().uuidString
    var title: String
    var shortDescription: String
    
    init(id: String = UUID().uuidString, title: String, shortDescription: String) {
        self.id = id
        self.title = title
        self.shortDescription = shortDescription
    }
    
    static var emptyModelKit: ModelKit {
        ModelKit(title: "", shortDescription: "")
    }
}

extension ModelKit {
    static let sampleData: [ModelKit] =
    [
        ModelKit(
            title: "F-35A",
            shortDescription: "Lockheed Martin F-35A Lightning II"
        ),
        ModelKit(
            title: "Hawk 81-A2",
            shortDescription: "Curtiss Hawk 81-A2 \"Flying Tigers\""
        ),
        ModelKit(
            title: "Spitfire Mk.1",
            shortDescription: "Spitfire Story: The Few (Spitfire Mk.I)"
        )
    ]
}
