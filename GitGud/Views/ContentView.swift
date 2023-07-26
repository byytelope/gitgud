//
//  ContentView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 17/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var username = "byytelope"

    var body: some View {
        TabView(selection: $selectedTab) {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(0)
            ProfileView(username: username)
                .tabItem {
                    Label("Profile", systemImage: "person\(selectedTab == 1 ? ".fill" : "")")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
