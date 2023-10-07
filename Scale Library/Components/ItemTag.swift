//
//  ItemTag.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 5/10/23.
//

import SwiftUI

struct ItemTag: View {
    var text: String
    var theme: Theme
    
    var body: some View {
        Group {
            Text(text)
                .font(Font.custom("HelveticaNeue-Medium", size: 12))
                .padding([.leading, .trailing], 10)
                .padding([.top, .bottom], 5)
                .foregroundColor(Color(theme.accentColor))
        }
        .background(Color(theme.mainColor))
        .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}

#Preview {
    ItemTag(text: "test", theme: Theme.Orange)
}
