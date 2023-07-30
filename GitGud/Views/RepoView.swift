//
//  RepoView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 31/07/2023.
//

import SwiftUI

struct RepoView: View {
    var repo: GitHubRepo

    var body: some View {
        Text(repo.name)
    }
}

#Preview {
    RepoView(repo: GitHubUser.mockUser.repos.first!)
}
