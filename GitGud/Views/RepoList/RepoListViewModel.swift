//
//  RepoListViewModel.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 22/07/2023.
//

import Foundation
import Observation

@Observable final class RepoListViewModel {
    var repos: [GitHubRepo]?

    func fetchData(username: String) async {
        do {
            repos = try await getRepos(username: username)
            repos = repos?.sorted(by: { $0.stargazersCount > $1.stargazersCount })
        } catch GHError.invalidUrl {
            print("REPOS: Invalid URL")
        } catch GHError.invalidData {
            print("REPOS: Invalid data")
        } catch GHError.invalidResponse {
            print("REPOS: Fetch failed")
        } catch {
            print("REPOS: Unknown error")
        }
    }

    func getRepos(username: String) async throws -> [GitHubRepo] {
        let endpoint = "https://api.github.com/users/\(username)/repos"
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidUrl
        }

        let (data, res) = try await URLSession.shared.data(from: url)
        guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {
            throw GHError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode([GitHubRepo].self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}
