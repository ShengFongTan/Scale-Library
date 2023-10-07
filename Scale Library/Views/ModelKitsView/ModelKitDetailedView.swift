//
//  ModelKitDetailedView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 1/10/23.
//

import SwiftUI

struct ModelKitDetailedView: View {
    var modelNamespace: Namespace.ID
    @Binding var index: Int
    @Binding var showDetail: Bool
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                List {
                    Spacer()
                        .clearListItem()
                    Section(header: Text("Kit Information")) {
                        VStack {
                            Image("f-35a")
                                .resizable()
                                .scaledToFit()
                                .matchedGeometryEffect(id: "image\(index)", in: modelNamespace)
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
                                Divider()
                                    .deferredRendering(for: 0.3)
                                HStack(alignment: .center, spacing: 4) {
                                    Text("Bought on")
                                        .font(.footnote)
                                    Text("27 June 2020")
                                        .font(.footnote)
                                        .bold()
                                    Spacer()
                                    Text("$55")
                                        .fontWeight(.bold)
                                }
                                .deferredRendering(for: 0.3)
                            }
                            .padding(20)
                        }
                        .background(
                            Rectangle()
                                .fill(.regularMaterial)
                                .matchedGeometryEffect(id: "blur\(index)", in: modelNamespace)
                        )
                        .mask(
                            RoundedRectangle(
                                cornerRadius: 30,
                                style: .continuous
                            )
                            .matchedGeometryEffect(id: "roundendedCornersMask\(index)", in: modelNamespace)
                        )
                        .standardShadow()
                        .clearListItem()
                    }
                    
                    Section(header: Text("Planned Projects")) {
                        VStack {
                            HStack(alignment: .top) {
                                Image("f-35a")
                                    .resizable()
                                //.scaledToFit()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 70, height: 70)
                                Spacer()
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("F-35A")
                                        .font(.title3.weight(.bold))
                                    Text("testetsetsetsetsettestetsetsetsetsettestetsetsetsetsettestetsetsetsetsettestetsetsetsetsettestetsetsetsetsettestetsetsetsetset")
                                        .font(.footnote)
                                }
                                //.padding([.leading], 1)
                            }
                            HStack(alignment: .center, spacing: 6) {
                                ItemTag(text: "1/48", theme: Theme.FieldBlue)
                                ItemTag(text: "Tamiya", theme: Theme.TwitterBlue)
                                ItemTag(text: "Aircraft", theme: Theme.Maroon)
                            }
                        }
                        .padding(20)
                        .background(
                            Rectangle()
                                .fill(.regularMaterial)
                        )
                        .mask(
                            RoundedRectangle(
                                cornerRadius: 30,
                                style: .continuous
                            )
                        )
                        .standardShadow()
                        .clearListItem()
                    }
                }
                .listStyle(PlainListStyle())
                
                HStack {
                    Button {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showDetail.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.body.weight(.bold))
                            .foregroundStyle(.secondary)
                            .padding(5)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .clearNavLink()
                    .lightShadow()
                    
                    Spacer()
                    
                    Button {
                        /// code
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.body.weight(.bold))
                            .foregroundStyle(.secondary)
                            .padding(10)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .clearNavLink()
                    .lightShadow()
                }
                .padding([.leading, .trailing], 20)
                .padding([.top], 25)
                
                /*
                 Set colour of top safe area
                 */
                GeometryReader { reader in
//                    Rectangle()
//                        .fill(.ultraThinMaterial)
//                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
//                        .ignoresSafeArea()
                    Color.white
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        .lightShadow()
                        .ignoresSafeArea()
                }
            }
            .background(
                ZStack {
                    //Color.black.opacity(0.2)
                    Rectangle()
                        .fill(.ultraThinMaterial)
                }
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    @Namespace var modelNamespace
    return ModelKitDetailedView(modelNamespace: modelNamespace, index: .constant(0), showDetail: .constant(true))
    //ModelKitsView()
}
