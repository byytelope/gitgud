//
//  RepoListHeaderView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 20/07/2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    var user: GitHubUser?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20) {
                AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                } placeholder: {
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                }

                VStack(alignment: .leading) {
                    Text(user?.name ?? "Name")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(user?.login ?? "Username")
                }

                Spacer()
            }
        }
    }
}
