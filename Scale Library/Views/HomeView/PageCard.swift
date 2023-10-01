//
//  PageCard.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 24/9/23.
//

import SwiftUI

struct PageCard: View {
    
    let title: String
    let image: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image("\(image)")
                .resizable()
                .scaledToFill()
                //.frame(width: 180, height: 150)
                .frame(maxWidth: 200, maxHeight: 180)
            Text("\(title)")
                .font(.headline)
                .padding(.horizontal, 15)
                .padding(.bottom, 16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.2), radius: 5)
    }
}

#Preview {
    PageCard(title: "Default Title", image: "model-kits")
}
