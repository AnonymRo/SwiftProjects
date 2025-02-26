//
//  UserViewModel.swift
//  Friends
//
//  Created by Sebastian Bușa on 26/2/25.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchUsers() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let jsonURL = "https://www.hackingwithswift.com/samples/friendface.json"
                users = try await UserService.shared.fetchUserData(from: jsonURL)
            } catch {
                errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
}
