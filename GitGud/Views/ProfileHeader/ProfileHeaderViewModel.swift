//
//  ProfileHeaderViewModel.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 18/07/2023.
//

import Foundation
import Observation

@Observable final class ProfileHeaderViewModel {
    var user: GitHubUser?

    func fetchData(username: String) async {
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
}
