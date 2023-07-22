//
//  RepoListView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 20/07/2023.
//

import SwiftUI

struct RepoListView: View {
    @State var viewModel = RepoListViewModel()

    var body: some View {
        Group {
            if viewModel.repos == nil {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.repos ?? []) { repo in
                        VStack(alignment: .leading, spacing: 12) {
                            Text(repo.name)
                                .bold()
                            HStack(spacing: 12) {
                                HStack {
                                    Image(systemName: "star")
                                        .symbolRenderingMode(.hierarchical)
                                        .foregroundStyle(.yellow)

                                    Text(String(repo.stargazersCount))
                                }

                                Text("·")

                                HStack(alignment: .center, spacing: 8) {
                                    Circle()
                                        .frame(height: 12)
                                        .foregroundStyle(repo.language.color)
                                    Text(repo.language.rawValue)
                                        .font(.callout)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Repositories")
        .task {
            await viewModel.fetchData(username: "byytelope")
        }
    }
}
