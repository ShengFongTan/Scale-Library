//
//  ModelCard.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 2/10/23.
//

import SwiftUI

struct ModelCard: View {
    var modelNamespace: Namespace.ID
    @Bindable var modelKit: ModelKit
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(modelKit.title)
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title\(modelKit.id)", in: modelNamespace)
                Text(modelKit.shortDescription)
                    .font(.footnote)
                    .matchedGeometryEffect(id: "description\(modelKit.id)", in: modelNamespace)
                HStack(alignment: .center, spacing: 6) {
                    ItemTag(text: "1/48", theme: Theme.FieldBlue)
                    ItemTag(text: "Tamiya", theme: Theme.TwitterBlue)
                    ItemTag(text: "Aircraft", theme: Theme.Maroon)
                }
                .matchedGeometryEffect(id: "tags\(modelKit.id)", in: modelNamespace)
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
                    .matchedGeometryEffect(id: "blur\(modelKit.id)", in: modelNamespace)
            )
        }
        .foregroundStyle(.white)
        .background(
            Image("f-35a")
                .resizable()
                .scaledToFill()
                .matchedGeometryEffect(id: "image\(modelKit.id)", in: modelNamespace)
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
                cornerRadius: 20,
                style: .continuous
            )
            .matchedGeometryEffect(id: "roundendedCornersMask\(modelKit.id)", in: modelNamespace)
        )
        .frame(height: 250)
        .standardShadow()
        //.padding()
    }
}

#Preview {
    @Namespace var modelNamespace
    return ModelCard(modelNamespace: modelNamespace, modelKit: ModelKit.sampleData[0])
}
