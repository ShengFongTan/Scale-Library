//
//  ModelKit.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class ModelKit: Identifiable {
    @Attribute(.unique) var id: String = UUID().uuidString
    
    @Attribute(.externalStorage)
    var image: Data?
    var title: String
    var shortDescription: String
    var price: Decimal
    var date: Date
    
    init(id: String = UUID().uuidString, image: Data?, title: String, shortDescription: String, price: Decimal, date: Date) {
        self.id = id
        self.image = image
        self.title = title
        self.shortDescription = shortDescription
        self.price = price
        self.date = date
    }
    
    static var emptyModelKit: ModelKit {
        ModelKit(image: nil, title: "", shortDescription: "", price: 0, date: .now)
    }
}

extension ModelKit {
    static let sampleData: [ModelKit] =
    [
        ModelKit(
            image: nil,
            title: "F-35A",
            shortDescription: "Lockheed Martin F-35A Lightning II",
            price: 95.5,
            date: .now
        ),
        ModelKit(
            image: nil,
            title: "Hawk 81-A2",
            shortDescription: "Curtiss Hawk 81-A2 \"Flying Tigers\"",
            price: 140.2,
            date: .now
        ),
        ModelKit(
            image: nil,
            title: "Spitfire Mk.1",
            shortDescription: "Spitfire Story: The Few (Spitfire Mk.I)",
            price: 120,
            date: .now
        ),
        ModelKit(
            image: nil,
            title: "Hurricane Mk IIc",
            shortDescription: "Hurricane Mk IIc Nightfighter",
            price: 60.37,
            date: .now
        )
    ]
}
