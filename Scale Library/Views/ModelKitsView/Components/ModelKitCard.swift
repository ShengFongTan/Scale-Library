//
//  ModelCard.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 2/10/23.
//

import SwiftUI

/*
 A sub-component used in ModelKitsView to represent each unique model kit
 in the grid view.
 
 Displays basic information of a model kit:
    - Image (In the background)
    - Title
    - Description
    - Scale
    - Brand
    - Category
 
 The elements which stores the information above are linked to their
 counterparts in ModelKitDetailView via the .matchedGeometryEffect modifier.
*/

struct ModelKitCard: View {
    var modelNamespace: Namespace.ID
    var modelKit: ModelKit
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(modelKit.title)
                    .font(.title2.weight(.bold))
                    .matchedGeometryEffect(id: "title\(modelKit.id)", in: modelNamespace)
                Text(modelKit.shortDescription)
                    .font(.footnote)
                    .matchedGeometryEffect(id: "description\(modelKit.id)", in: modelNamespace)
                HStack(alignment: .center, spacing: 6) {
                    ItemTag(text: "1/48", theme: Theme.FieldBlue)
                        .matchedGeometryEffect(id: "scale\(modelKit.id)", in: modelNamespace)
                    ItemTag(text: "Tamiya", theme: Theme.TwitterBlue)
                        .matchedGeometryEffect(id: "brand\(modelKit.id)", in: modelNamespace)
                    ItemTag(text: "Aircraft", theme: Theme.Maroon)
                        .matchedGeometryEffect(id: "category\(modelKit.id)", in: modelNamespace)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                    )
                    .blur(radius: 30)
            )
        }
        .foregroundStyle(.white)
        .background(
            ZStack {
                Color(.lightGray)
                Group {
                    if (modelKit.image != nil) {
                        Image(uiImage: UIImage(data: modelKit.image!)!)
                            .resizable()
                            .scaledToFill()
                            .matchedGeometryEffect(id: "image\(modelKit.id)", in: modelNamespace)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .opacity(0.3)
                            .scaledToFit()
                            .padding()
                            .matchedGeometryEffect(id: "image\(modelKit.id)", in: modelNamespace)
                    }
                }
            }
        )
        .contentShape(Rectangle()) // Prevents invisible overflowed portion of background image from activating .onTapGesture
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .matchedGeometryEffect(id: "roundendedCornersMask\(modelKit.id)", in: modelNamespace)
        .frame(height: 250)
        .standardShadow()
    }
}

#Preview {
    @Namespace var modelNamespace
    let preview = PreviewContainer([ModelKit.self])
    return ModelKitCard(
        modelNamespace: modelNamespace,
        modelKit: ModelKit.sampleData[0]
    )
    .modelContainer(preview.container)
}
