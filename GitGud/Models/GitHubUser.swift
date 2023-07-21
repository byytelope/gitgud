//
//  GitHubUser.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 18/07/2023.
//

import Foundation

struct GitHubUser: Codable {
    let name: String
    let login: String
    let avatarUrl: String
    let bio: String?
    let blog: String
    let location: String
}
