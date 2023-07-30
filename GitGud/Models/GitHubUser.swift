//
//  GitHubUser.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 18/07/2023.
//

import Foundation
import Observation

@Observable
final class GitHubUser: Codable, Identifiable {
    let id: Int
    let name: String?
    let login: String
    let avatarUrl: String
    let bio: String?
    let blog: String
    let location: String?
    let twitterUsername: String?
    let followers: Int
    let following: Int
    var repos: [GitHubRepo]

    init(id: Int, name: String?, login: String, avatarUrl: String, bio: String?, blog: String, location: String?, twitterUsername: String?, followers: Int, following: Int, repos: [GitHubRepo]) {
        self.id = id
        self.name = name
        self.login = login
        self.avatarUrl = avatarUrl
        self.bio = bio
        self.blog = blog
        self.location = location
        self.twitterUsername = twitterUsername
        self.followers = followers
        self.following = following
        self.repos = repos
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String?.self, forKey: .name)
        login = try container.decode(String.self, forKey: .login)
        avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        bio = try container.decode(String?.self, forKey: .bio)
        blog = try container.decode(String.self, forKey: .blog)
        location = try container.decode(String?.self, forKey: .location)
        twitterUsername = try container.decode(String?.self, forKey: .twitterUsername)
        followers = try container.decode(Int.self, forKey: .followers)
        following = try container.decode(Int.self, forKey: .following)
        repos = []
    }

    static let mockUser = GitHubUser(id: 1, name: "Full Name", login: "username", avatarUrl: "https://avatars.githubusercontent.com/u/543186?v=4", bio: "This is a bio", blog: "website.co", location: "City, Country", twitterUsername: "twtusr", followers: 12, following: 20,
                                     repos: [
                                         GitHubRepo(id: UUID().hashValue, name: "repo_1", fullName: "username/repo_1", stargazersCount: 20, language: .Rust),
                                         GitHubRepo(id: UUID().hashValue, name: "repo_2", fullName: "username/repo_2", stargazersCount: 0, language: .Cpp),
                                         GitHubRepo(id: UUID().hashValue, name: "repo_3", fullName: "username/repo_3", stargazersCount: 10000, language: .Python),
                                         GitHubRepo(id: UUID().hashValue, name: "repo_1", fullName: "username/repo_1", stargazersCount: 20, language: .Rust),
                                         GitHubRepo(id: UUID().hashValue, name: "repo_2", fullName: "username/repo_2", stargazersCount: 0, language: .Cpp),
                                         GitHubRepo(id: UUID().hashValue, name: "repo_3", fullName: "username/repo_3", stargazersCount: 10000, language: .Python),
                                         GitHubRepo(id: UUID().hashValue, name: "repo_1", fullName: "username/repo_1", stargazersCount: 20, language: .Rust),
                                         GitHubRepo(id: UUID().hashValue, name: "repo_2", fullName: "username/repo_2", stargazersCount: 0, language: .Cpp),
                                         GitHubRepo(id: UUID().hashValue, name: "repo_3", fullName: "username/repo_3", stargazersCount: 10000, language: .Python),
                                         GitHubRepo(id: UUID().hashValue, name: "repo_1", fullName: "username/repo_1", stargazersCount: 20, language: .Rust),
                                         GitHubRepo(id: UUID().hashValue, name: "repo_2", fullName: "username/repo_2", stargazersCount: 0, language: .Cpp),
                                         GitHubRepo(id: UUID().hashValue, name: "repo_3", fullName: "username/repo_3", stargazersCount: 10000, language: .Python),
                                     ])
}
