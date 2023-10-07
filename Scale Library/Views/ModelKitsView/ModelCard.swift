//
//  ModelCard.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 2/10/23.
//

import SwiftUI

struct ModelCard: View {
    var modelNamespace: Namespace.ID
    var index: Int
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text("F-35A")
                    .font(.title2.weight(.bold))
                    .matchedGeometryEffect(id: "title\(index)", in: modelNamespace)
                Text("Some random description of the model here....")
                    .font(.footnote)
                    .matchedGeometryEffect(id: "description\(index)", in: modelNamespace)
                HStack(alignment: .center, spacing: 6) {
                    ItemTag(text: "1/48", theme: Theme.FieldBlue)
                    ItemTag(text: "Tamiya", theme: Theme.TwitterBlue)
                    ItemTag(text: "Aircraft", theme: Theme.Maroon)
                }
                .matchedGeometryEffect(id: "tags\(index)", in: modelNamespace)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                    )
                    .blur(radius: 40)
                    .matchedGeometryEffect(id: "blur\(index)", in: modelNamespace)
            )
        }
        .foregroundStyle(.white)
        .background(
            Image("f-35a")
                .resizable()
                .scaledToFill()
                .matchedGeometryEffect(id: "image\(index)", in: modelNamespace)
        )
        .background(
            ZStack {
                Image("f-35a")
                    .resizable()
                    .scaledToFill()
                Rectangle()
                    .fill(.ultraThinMaterial)
            }
        )
        .mask(
            RoundedRectangle(
                cornerRadius: 30,
                style: .continuous
            )
            .matchedGeometryEffect(id: "roundendedCornersMask\(index)", in: modelNamespace)
        )
        .frame(height: 300)
        .standardShadow()
        .padding()
    }
}

#Preview {
    @Namespace var modelNamespace
    return ModelCard(modelNamespace: modelNamespace, index: 0)
    //ModelKitsView()
}
