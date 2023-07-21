//
//  GitHubRepo.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 20/07/2023.
//

import Foundation
import SwiftUI

struct GitHubRepo: Codable, Identifiable {
    let id: Int
    let name: String
    let fullName: String
    let stargazersCount: Int
    let language: Language

    enum CodingKeys: String, CodingKey {
        case id, name, fullName, stargazersCount, language
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        fullName = try container.decode(String.self, forKey: .fullName)
        stargazersCount = try container.decode(Int.self, forKey: .stargazersCount)

        if let languageString = try container.decodeIfPresent(String.self, forKey: .language) {
            language = Language(rawValue: languageString) ?? .Other
        } else {
            language = .Other
        }
    }
}

enum Language: String, Codable {
    case C
    case Cpp = "C++"
    case CSS
    case Dart
    case Go
    case HTML
    case Java
    case JavaScript
    case Python
    case Rust
    case Svelte
    case Swift
    case TypeScript
    case Vue
    case Other

    var color: Color {
        switch self {
        case .C: return Color(.cLang)
        case .Cpp: return Color(.cpp)
        case .CSS: return Color(.css)
        case .Dart: return Color(.dart)
        case .Go: return Color(.go)
        case .HTML: return Color(.html)
        case .Java: return Color(.java)
        case .JavaScript: return Color(.javaScript)
        case .Python: return Color(.python)
        case .Rust: return Color(.rust)
        case .Svelte: return Color(.svelte)
        case .Swift: return Color(.swift)
        case .TypeScript: return Color(.typeScript)
        case .Vue: return Color(.vue)
        case .Other: return Color(.other)
        }
    }
}
