//
//  ContentView.swift
//  Scale Library
//
//  Created by Tan Sheng Fong on 23/9/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @State var test = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color("HomeBackground")
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    Section(header: Text("Pages")) {
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            LazyHStack(spacing: 20) {
                                NavigationLink(destination: PageView()) {
                                    PageCard(title: "Projects", image: "model-kits")
                                }.modifier(.clearNavLinkStyle)
                                NavigationLink(destination: PageView()) {
                                    PageCard(title: "Model Kits", image: "model-kits")
                                }.modifier(.clearNavLinkStyle)
                                NavigationLink(destination: PageView()) {
                                    PageCard(title: "Accessories", image: "model-kits")
                                }.modifier(.clearNavLinkStyle)
                                NavigationLink(destination: PageView()) {
                                    PageCard(title: "Paints", image: "model-kits")
                                }.modifier(.clearNavLinkStyle)
                            }
                            .padding(20)
                        })
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                    
                    Section(header: Text("Stash overview")) {
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
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
            }
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
    HomeView()
        .environmentObject(LaunchScreenManager())
}
