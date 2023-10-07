//
//  Theme.swift
//  Scrumdinger
//
//  Created by Tan Sheng Fong on 16/9/23.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case Bubblegum
    case Buttercup
    case DarkClay
    case FieldBlue
    case Indigo
    case Khaki
    case Lavender
    case Magenta
    case Maroon
    case MediumBlue
    case Navy
    case Orange
    case Oxblood
    case Periwinkle
    case Poppy
    case Purple
    case Seafoam
    case Shadow
    case Sky
    case Tan
    case Teal
    case TwitterBlue
    case Yellow
    
    var accentColor: Color {
        switch self {
        case .Bubblegum, .Buttercup, .Lavender, .Orange, .Periwinkle, .Poppy, .Seafoam, .Sky, .Tan, .Teal, .Yellow: return .black
        case .Indigo, .Magenta, .Navy, .Oxblood, .Purple, .Khaki, .FieldBlue, .TwitterBlue, .Maroon, .MediumBlue, .Shadow, .DarkClay: return .white
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String {
        let pattern = "([a-z])([A-Z])"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        let range = NSRange(location: 0, length: rawValue.utf16.count)
        var result = regex.stringByReplacingMatches(in: rawValue, options: [], range: range, withTemplate: "$1 $2")
        
        // Capitalize the first letter of the resulting string
        result.replaceSubrange(result.startIndex...result.startIndex, with: String(result[result.startIndex]).capitalized)
        
        return result
    }
    
    var id: String {
        name
    }
}
