//
//  ModelKitDetailView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 9/10/23.
//

import SwiftUI

struct ModelKitDetailView: View {
    @Environment(\.modelContext) private var context
    var modelNamespace: Namespace.ID
    @Binding var modelKit: ModelKit
    @Binding var showDetail: Bool
    @State private var showEditModelKit = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color(.white)
                    .ignoresSafeArea()
                
                ScrollView {
                    ZStack {
                        LinearGradient(
                            colors: [Color(.twitterBlue), Color(.mediumBlue)],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .frame(height: 800)
                        .offset(y: -400) /// If no offset, background colour will show if user scroll up.
                        .standardShadow()
                        
                        VStack(spacing: 40) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(modelKit.title)
                                    .font(.largeTitle.weight(.bold))
                                    .matchedGeometryEffect(id: "title\(modelKit.id)", in: modelNamespace)
                                Text(modelKit.shortDescription)
                                    .font(.footnote)
                                    .matchedGeometryEffect(id: "description\(modelKit.id)", in: modelNamespace)
                                HStack(alignment: .center, spacing: 6) {
                                    ItemTag(text: "1/48", theme: Theme.FieldBlue)
                                        .lightShadow()
                                    ItemTag(text: "Tamiya", theme: Theme.TwitterBlue)
                                        .lightShadow()
                                    ItemTag(text: "Aircraft", theme: Theme.Maroon)
                                        .lightShadow()
                                }
                                .matchedGeometryEffect(id: "tags\(modelKit.id)", in: modelNamespace)
                            }
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 80)
                            
                            VStack(spacing: 10) {
                                Image("f-35a")
                                    .resizable()
                                    .scaledToFit()
                                    .matchedGeometryEffect(id: "image\(modelKit.id)", in: modelNamespace)
                                    .mask(
                                        RoundedRectangle(
                                            cornerRadius: 20,
                                            style: .continuous
                                        )
                                        .matchedGeometryEffect(id: "roundendedCornersMask\(modelKit.id)", in: modelNamespace)
                                    )
                                    .standardShadow()
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
                                .deferredRendering()
                                Divider()
                                    .deferredRendering()
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Planned project")
                                    .font(.caption)
                                VStack {
                                    HStack(alignment: .top) {
                                        Image("f-35a")
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 70, height: 70)
                                            .padding(.trailing, 10)
                                        VStack(alignment: .leading, spacing: 12) {
                                            Text("F-35A")
                                                .font(.title3.weight(.bold))
                                            Text("testetsetsetsetsettestetsetsetsetsettestetsetsetsetsettestetsetsetsetsettestetsetsetsetsettestetsetsetsetsettestetsetsetsetset")
                                                .font(.footnote)
                                        }
                                        Spacer()
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
                                        .fill(.thickMaterial)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .lightShadow()
                            }
                            .padding(.bottom, 50)
                            .deferredRendering()
                        }
                        .padding(.top, geometry.safeAreaInsets.top) // Provide padding for safe area when horizontal
                        .padding(.bottom, geometry.safeAreaInsets.bottom) // Provide padding for safe area when horizontal
                        .padding(.leading, geometry.safeAreaInsets.leading * 5) // Provide padding for safe area when horizontal
                        .padding(.trailing, geometry.safeAreaInsets.trailing * 5) // Provide padding for safe area when horizontal
                        .padding() // Provides padding in portrait mode
                    }
                }
                .scrollIndicators(.hidden)
                .ignoresSafeArea()
                
                HStack {
                    Button {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            showDetail.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.body.weight(.bold))
                            .foregroundStyle(.secondary)
                            .padding(6)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .clearNavLink()
                    
                    Spacer()
                    
                    Menu {
                        Button("Edit", systemImage: "pencil", action: {showEditModelKit = true})
                        Button("Delete", systemImage: "xmark.bin", role: .destructive, action: {
                            context.delete(modelKit)
                            do {
                                try context.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            showDetail.toggle()
                        })
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.body.weight(.bold))
                            .foregroundStyle(Color(.darkGrey))
                            .padding(10)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                }
                .padding(.leading, 13)
                .padding(.trailing, 20)
                .padding(.top, 20)
            }
            .fullScreenCover(isPresented: $showEditModelKit) {
                EditModelKitSheet(modelKit: $modelKit)
            }
        }
    }
}

#Preview {
    @Namespace var modelNamespace
    return ModelKitDetailView(modelNamespace: modelNamespace, modelKit: .constant(ModelKit.sampleData[0]), showDetail: .constant(true))
}
