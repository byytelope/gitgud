//
//  ProfileHeaderView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 20/07/2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    var user: GitHubUser

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 20) {
                AsyncImage(url: URL(string: user.avatarUrl)) { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                }

                VStack(alignment: .leading) {
                    if let name = user.name {
                        Text(name)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }

                    Text(user.login)
                }

                Spacer()
            }

            if let bio = user.bio {
                Text(bio)
            }

            VStack(alignment: .leading, spacing: 14) {
                if let location = user.location {
                    HStack {
                        Image(systemName: "mappin")

                        Text(location)
                    }
                }

                if !user.blog.isEmpty {
                    HStack {
                        Image(systemName: "link")

                        Text(.init("[\(user.blog)](https://\(user.blog))"))
                            .bold()
                            .tint(.primary)
                    }
                }

                if let twtUsername = user.twitterUsername {
                    HStack {
                        Image("twitterSymbol")

                        Text(.init("[\(twtUsername)](https://twitter.com/\(twtUsername))"))
                            .bold()
                            .tint(.primary)
                    }
                }

                HStack {
                    Image(systemName: "person")

                    Text("**\(user.followers)** followers")

                    Text("·")

                    Text("**\(user.following)** following")
                }
            }
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ProfileHeaderView(
        user: .mockUser
    )
}
