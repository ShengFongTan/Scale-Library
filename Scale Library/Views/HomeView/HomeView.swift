//
//  ContentView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import SwiftUI
import SwiftData

/*
 First view displayed after app launch.
 Home view where users can view and navigate to all the main pages:
    - Projects
    - Model Kits
    - Accessories
    - Paints
 Also displays overview information
*/

struct HomeView: View {
    var modelContext: ModelContext
    
    var body: some View {
        NavigationStack {
            List {
                // Horizontal scrollview with the main pages
                Section {
                    ScrollView(.horizontal, content: {
                        LazyHStack(spacing: 20) {
                            NavigationLink(destination: ProjectsView()) {
                                PageCard(title: "Projects", image: "model-kits")
                            }
                            .clearNavLink()
                            NavigationLink(destination: ModelKitsView(modelContext: modelContext)) {
                                PageCard(title: "Model Kits", image: "f-4")
                            }
                            .clearNavLink()
                            NavigationLink(destination: AccessoriesView()) {
                                PageCard(title: "Accessories", image: "model-kits")
                            }
                            .clearNavLink()
                            NavigationLink(destination: PaintsView()) {
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
                
                // Stash overview
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
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

#Preview {
    let preview = PreviewContainer([ModelKit.self])
    return HomeView(modelContext: preview.container.mainContext)
        .modelContainer(preview.container)
        .environment(Observables())
}
