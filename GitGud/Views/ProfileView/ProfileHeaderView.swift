//
//  RepoListHeaderView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 20/07/2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State private var viewModel = ProfileHeaderViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 20) {
                AsyncImage(url: URL(string: viewModel.user?.avatarUrl ?? "")) { image in
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
                    Text(viewModel.user?.name ?? "Full Name")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(viewModel.user?.login ?? "username")
                }

                Spacer()
            }

            Text(viewModel.user?.bio ?? "This is a bio placeholder")

            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Image(systemName: "mappin")

                    Text(viewModel.user?.location ?? "City, Country")
                }

                if viewModel.user?.blog != nil {
                    HStack {
                        Image(systemName: "link")

                        Text(.init("[\(viewModel.user?.blog ?? "website.com")](https://\(viewModel.user?.blog ?? "website.com"))"))
                            .bold()
                            .tint(.primary)
                    }
                }

                if viewModel.user?.twitterUsername != nil {
                    HStack {
                        Image("twitterSymbol")

                        Text(.init("[\(viewModel.user?.twitterUsername ?? "twitter")](https://twitter.com/\(viewModel.user?.twitterUsername ?? ""))"))
                            .bold()
                            .tint(.primary)
                    }
                }

                HStack {
                    Image(systemName: "person")

                    Text("**\(viewModel.user?.followers ?? 0)** followers")

                    Text("·")

                    Text("**\(viewModel.user?.following ?? 0)** following")
                }
            }
            .foregroundStyle(.secondary)
        }
        .redacted(reason: viewModel.user == nil ? .placeholder : [])
        .task {
            await viewModel.fetchData(username: "byytelope")
        }
    }
}
