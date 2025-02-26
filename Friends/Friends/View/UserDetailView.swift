//
//  UserDetailView.swift
//  Friends
//
//  Created by Sebastian Bușa on 26/2/25.
//

import SwiftUI

struct UserDetailView: View {
    
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Company: \(user.company)")
                    .font(.title3)
                    .foregroundStyle(.gray)
                
                Text("Email: \(user.email)")
                    .font(.subheadline)
                
                Text("Address: \(user.address)")
                    .font(.subheadline)
                
                Text("About")
                    .font(.headline)
                    .padding(.top, 10)
                
                Text(user.about)
                    .font(.body)
                
                Text("Tags: \(user.tags.joined(separator: ", "))")
                    .font(.footnote)
                    .foregroundStyle(.blue)
                
                if !user.friends.isEmpty {
                    Text("Friends")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(user.friends) { friend in
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(.blue)
                                Text(friend.name)
                                    .font(.body)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding()
        }
        .navigationTitle(user.name)
    }
}

#Preview {
    UserDetailView(user: MockData.users.first!)
}
