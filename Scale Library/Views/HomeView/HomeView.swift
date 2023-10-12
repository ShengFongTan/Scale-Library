//
//  ContentView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ScrollView(.horizontal, content: {
                        LazyHStack(spacing: 20) {
                            NavigationLink(destination: ModelKitsView()) {
                                PageCard(title: "Projects", image: "model-kits")
                            }
                            .clearNavLink()
                            NavigationLink(destination: ModelKitsView()) {
                                PageCard(title: "Model Kits", image: "f-4")
                            }
                            .clearNavLink()
                            NavigationLink(destination: ModelKitsView()) {
                                PageCard(title: "Accessories", image: "model-kits")
                            }
                            .clearNavLink()
                            NavigationLink(destination: ModelKitsView()) {
                                PageCard(title: "Paints", image: "model-kits")
                            }
                            .clearNavLink()
                        }
                        .padding()
                    })
                    .clearListItem()
                    .scrollIndicators(.hidden)
                    .listRowInsets(EdgeInsets())
                } header: {
                    Text("Pages")
                }
                
                Section {
                    VStack(spacing: 30) {
                        OverviewCard(
                            icon: "checklist",
                            title: "Projects",
                            smallText: "Planned projects",
                            count: 4
                        )
                        OverviewCard(
                            icon: "shippingbox",
                            title: "Model kits",
                            smallText: "Total costs: $2175",
                            count: 56
                        )
                        OverviewCard(
                            icon: "wand.and.stars",
                            title: "Accessories",
                            smallText: "Total costs: $1530",
                            count: 76
                        )
                        OverviewCard(
                            icon: "paintpalette",
                            title: "Paints",
                            smallText: "Total costs: $560",
                            count: 45
                        )
                    }
                    .clearListItem()
                } header: {
                    Text("Stash Overview")
                }
            }
            .listStyle(.plain)
            .navigationTitle("Scale Library")
        }
        .onAppear {
            /// Simulate retrieving data. delay of 5 seconds before dismissing launch screen
            DispatchQueue
                .main
                .asyncAfter(deadline: .now() + 3) {
                    launchScreenManager.dismiss()
                }
        }
    }
}

#Preview {
    let preview = PreviewContainer([ModelKit.self])
    return HomeView()
        .modelContainer(preview.container)
        .environmentObject(LaunchScreenManager())
}
