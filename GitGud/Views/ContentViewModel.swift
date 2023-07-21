//
//  ContentViewModel.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 18/07/2023.
//

import Foundation
import Observation

@Observable final class ContentViewModel {
    var user: GitHubUser?
    var repos: [GitHubRepo]?

    func fetchReposData(username: String) async {
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

    func fetchUserData(username: String) async {
        do {
            user = try await getUser(username: username)
        } catch GHError.invalidUrl {
            print("USER: Invalid URL")
        } catch GHError.invalidData {
            print("USER: Invalid data")
        } catch GHError.invalidResponse {
            print("USER: Fetch failed")
        } catch {
            print("USER: Unknown error")
        }
    }

    func getUser(username: String) async throws -> GitHubUser {
        let endpoint = "https://api.github.com/users/\(username)"
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

            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw GHError.invalidData
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
