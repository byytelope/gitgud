//
//  SearchViewModel.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 04/08/2023.
//

import Foundation
import Observation

@Observable final class SearchViewModel {
    var searchList = [BasicUser]()

    func fetchData(searchQuery: String) async {
        if searchQuery.isEmpty {
            searchList = []
        } else {
            do {
                searchList = try await search(searchQuery: searchQuery)
            } catch let e {
                handleErrors(e, prefix: "SEARCH")
            }
        }
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

    func search(searchQuery: String) async throws -> [BasicUser] {
        let endpoint = "https://api.github.com/search/users?q=\(searchQuery)"
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

            let rootObj = try decoder.decode(BasicUserRoot.self, from: data)
            return rootObj.items
        } catch {
            throw GitHubError.invalidData
        }
    }
}
