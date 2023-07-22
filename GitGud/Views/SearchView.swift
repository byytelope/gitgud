//
//  SearchView.swift
//  GitGud
//
//  Created by Mohamed Shadhaan on 22/07/2023.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("Find a user")
                    .font(.title3)
                    .bold()

                Text("Search for users and select to know more about them")
                    .multilineTextAlignment(.center)
            }
            .padding()
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search for GitHub users")
        }
    }
}

#Preview {
    SearchView()
}
