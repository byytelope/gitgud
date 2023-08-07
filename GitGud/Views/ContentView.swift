//
//  ContentView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 17/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = Tab.search
    @State private var navPath = NavigationPath()
    @State private var username = ""

    enum Tab: Hashable {
        case search
        case profile
    }

    var body: some View {
        TabView(selection: $selectedTab.onUpdate {
            if $selectedTab.wrappedValue == .profile {
                while navPath.count >= 1 {
                    navPath.removeLast()
                }
            }
        }) {
            SearchView(username: $username)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)
            ProfileView(navPath: $navPath, username: $username)
                .tabItem {
                    Label("Profile", systemImage: "person\(selectedTab == .profile ? ".fill" : "")")
                        .environment(\.symbolVariants, selectedTab == .profile ? .fill : .none)
                }
                .tag(Tab.profile)
        }
    }
}

extension Binding {
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
}

#Preview {
    ContentView()
}
