//
//  ProfileViewModel.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 27/07/2023.
//

import Foundation
import Observation

@Observable final class ProfileViewModel {
    var user: GitHubUser?
    var loading = true

    func fetchData(username: String) async {
        do {
            user = try await getUser(username: username)
        } catch let e {
            handleErrors(e, prefix: "USER")
        }

        do {
            var repos = try await getRepos(username: username)
            repos = repos.sorted(by: { $0.stargazersCount > $1.stargazersCount })
            user?.repos = repos
        } catch let e {
            handleErrors(e, prefix: "REPOS")
        }

        loading = false
    }

    func handleErrors(_ error: Error, prefix: String) {
        switch error {
            case GitHubError.invalidUrl:
                print("\(prefix): Invalid URL")
            case GitHubError.invalidData:
                print("\(prefix): Invalid data")
            case GitHubError.invalidResponse:
                print("\(prefix): Fetch failed")
            default:
                print("\(prefix): Unknown error")
        }
    }

    func getUser(username: String) async throws -> GitHubUser {
        let endpoint = "https://api.github.com/users/\(username)"
        guard let url = URL(string: endpoint) else {
            throw GitHubError.invalidUrl
        }

        let (data, res) = try await URLSession.shared.data(from: url)
        guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {
            throw GitHubError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw GitHubError.invalidData
        }
    }

    func getRepos(username: String) async throws -> [GitHubRepo] {
        let endpoint = "https://api.github.com/users/\(username)/repos"
        guard let url = URL(string: endpoint) else {
            throw GitHubError.invalidUrl
        }

        let (data, res) = try await URLSession.shared.data(from: url)
        guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {
            throw GitHubError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode([GitHubRepo].self, from: data)
        } catch {
            throw GitHubError.invalidData
        }
    }
}
