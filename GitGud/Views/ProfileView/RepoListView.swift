//
//  RepoListView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 20/07/2023.
//

import SwiftUI

struct RepoListView: View {
    @State var repos: [GitHubRepo]
    @State private var searchText = ""

    private var repoResults: [GitHubRepo] {
        if searchText.isEmpty {
            return repos
        } else {
            return repos.filter { $0.fullName.contains(searchText) }
        }
    }

    var body: some View {
        if repos.isEmpty {
            ContentUnavailableView {
                Label("No Repos Found", systemImage: "slash.circle")
            } description: {
                Text("This user currently has no repos on GitHub.")
            }
            .navigationTitle("Repositories")
        } else {
            List {
                ForEach(repoResults) { repo in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(repo.name)
                            .bold()
                        HStack(spacing: 12) {
                            HStack {
                                Image(systemName: "star.fill")
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(.yellow)

                                Text(String(repo.stargazersCount))
                            }

                            Text("·")

                            HStack(alignment: .center, spacing: 8) {
                                Circle()
                                    .frame(height: 16)
                                    .foregroundStyle(repo.language.color)
                                Text(repo.language.rawValue)
                                    .font(.callout)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Repositories")
            .searchable(text: $searchText)
            .textInputAutocapitalization(.never)
        }
    }
}

#Preview {
    RepoListView(repos: [])
}
