//
//  ProfileView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 22/07/2023.
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    var username: String
    var body: some View {
        NavigationStack {
            if let user = viewModel.user {
                List {
                    Section {
                        ProfileHeaderView(user: user)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .padding(.top)

                    NavigationLink(value: user.repos) {
                        Text("Repositories")
                    }
                }
                .navigationTitle("Profile")
                .navigationDestination(for: [GitHubRepo].self) { repos in
                    RepoListView(repos: repos)
                }
                .navigationDestination(for: GitHubRepo.self) { repo in
                    RepoView(repo: repo)
                }
                .refreshable {
                    await viewModel.fetchData(username: username)
                }
            } else {
                ProgressView()
                    .navigationTitle("Profile")
            }
        }
        .task {
            await viewModel.fetchData(username: username)
        }
    }
}

#Preview {
    ProfileView(username: "byytelope")
}
