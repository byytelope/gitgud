//
//  ContentView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 17/07/2023.
//

import SwiftUI

struct ContentView: View {
    private var viewModel = ContentViewModel()

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ProfileHeaderView(user: viewModel.user)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .padding(.top)

                NavigationLink("Repositories") {
                    RepoListView(repos: viewModel.repos)
                }
            }
            .navigationTitle("Profile")
        }
        .task {
            await viewModel.fetchUserData(username: "byytelope")
            await viewModel.fetchReposData(username: "byytelope")
        }
    }
}

#Preview {
    ContentView()
}
