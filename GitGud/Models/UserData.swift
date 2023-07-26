//
//  UserData.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 27/07/2023.
//

import Foundation
import Observation

@Observable
final class UserData {
    let id: Int
    let username: String

    init(id: Int, username: String) {
        self.id = id
        self.username = username
    }
}
