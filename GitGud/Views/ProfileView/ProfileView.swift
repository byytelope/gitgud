//
//  ProfileView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 22/07/2023.
//

import SwiftUI

struct ProfileView: View {
    @State private var showSheet = false

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
        .sheet(isPresented: $showSheet) {
            Text("Hi")
        }
    }
}

#Preview {
    ProfileView()
}
