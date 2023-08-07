//
//  SearchUser.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 04/08/2023.
//

import Foundation

struct BasicUser: Codable, Identifiable {
    let id: Int
    let avatarUrl: String
    let login: String
}

extension BasicUser: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: BasicUser, rhs: BasicUser) -> Bool {
        return lhs.id == rhs.id
    }
}

struct BasicUserRoot: Codable {
    let items: [BasicUser]
}
