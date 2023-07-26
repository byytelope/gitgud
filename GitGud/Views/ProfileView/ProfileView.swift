//
//  ProfileView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 22/07/2023.
//

import SwiftUI

struct ProfileView: View {
    var username: String
    @State private var viewModel = ProfileViewModel()

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

                    NavigationLink("Repositories") {
                        RepoListView(repos: user.repos)
                    }
                }
                .navigationTitle("Profile")
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
    ProfileView(username: "user123")
}
