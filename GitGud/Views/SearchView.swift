//
//  SearchView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 22/07/2023.
//

import SwiftUI

struct SearchView: View {
    @State private var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var timer: Timer?
    @State private var loading = false
    @Binding var username: String
    @Environment(\.dismissSearch) private var dismissSearch

    var body: some View {
        NavigationStack {
            List(viewModel.searchList) { searchUser in
                Button {
                    username = searchUser.login
                } label: {
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: searchUser.avatarUrl)) { image in
                            image
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        } placeholder: {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                        }

                        Text(searchUser.login)
                            .foregroundStyle(Color.primary)

                        Spacer()

                        if searchUser.login == username {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search for GitHub users")
            .onSubmit {
                dismissSearch()
            }
            .submitLabel(.done)
            .textInputAutocapitalization(.never)
            .overlay {
                if viewModel.searchList.isEmpty, searchText.isEmpty {
                    ContentUnavailableView("Find Users", systemImage: "binoculars", description: Text("Search for users on GitHub and select to view details in the profile tab"))
                } else if viewModel.searchList.isEmpty, !searchText.isEmpty, !loading {
                    ContentUnavailableView.search
                } else if loading, !searchText.isEmpty {
                    ProgressView()
                }
            }
            .onChange(of: searchText) {
                loading = true
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                    Task {
                        await viewModel.fetchData(searchQuery: searchText)
                        loading = false
                    }
                })
            }
        }
    }
}

#Preview {
    SearchView(username: .constant(""))
}
