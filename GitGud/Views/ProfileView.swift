//
//  ProfileView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 22/07/2023.
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    @Binding var navPath: NavigationPath
    @Binding var username: String

    var body: some View {
        NavigationStack(path: $navPath) {
            if !username.isEmpty {
                if let user = viewModel.user, !viewModel.loading {
                    List {
                        Section {
                            ProfileHeaderView(user: user)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .padding(.top)

                        NavigationLink(value: user.repos) {
                            HStack {
                                Image(systemName: "book.closed")

                                Text("Repositories")

                                Spacer()

                                Text("\(user.repos.count)")
                                    .foregroundColor(.secondary)
                            }
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
            } else {
                ContentUnavailableView("No User Selected", systemImage: "person.slash", description: Text("Select a user from the search tab"))
                    .navigationTitle("Profile")
            }
        }
        .task {
            if !username.isEmpty {
                await viewModel.fetchData(username: username)
            }
        }
    }
}

#Preview {
    ProfileView(navPath: .constant(NavigationPath()), username: .constant(""))
}
