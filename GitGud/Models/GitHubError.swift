//
//  GHError.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 20/07/2023.
//

import Foundation

enum GitHubError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}
