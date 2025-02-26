//
//  ContentView.swift
//  Friends
//
//  Created by Sebastian Bușa on 26/2/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if !viewModel.users.isEmpty {
                    List(viewModel.users) { user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.title2)
                                    .bold()
                                
                                Text("Company: \(user.company)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Text("Tags: \(user.tags.joined(separator: ", "))")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                                
                                Text("Friends: \(user.friends.count)")
                                    .font(.footnote)
                            }
                            .padding()
                        }
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
            }
            .onAppear {
                viewModel.fetchUsers()
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    UserListView()
}
