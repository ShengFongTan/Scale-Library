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
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                Text("\(title)")
                    .font(.title2.weight(.bold))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                    )
                    .blur(radius: 35)
            )
        }
        .foregroundStyle(.white)
        .background(
            Image("\(image)")
                .resizable()
                .scaledToFill()
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .frame(width: 200, height: 200)
        .standardShadow()
    }
}

#Preview {
    PageCard(title: "Default Title", image: "model-kits")
}
