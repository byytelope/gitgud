//
//  ProfileView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 22/07/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ProfileHeaderView()
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .padding(.top)

                NavigationLink("Repositories") {
                    RepoListView()
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
