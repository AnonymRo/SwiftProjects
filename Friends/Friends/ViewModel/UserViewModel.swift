//
//  UserViewModel.swift
//  Friends
//
//  Created by Sebastian Bușa on 26/2/25.
//

import Foundation
import SwiftData

@Observable
class UserViewModel {
    var modelContext: ModelContext? = nil
    var users: [User] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    func loadUsersFromPersistenceStorage() {
        let fetchDescriptor = FetchDescriptor<User>(
            sortBy: [SortDescriptor(\.name)]
        )
        
        let storedUsers = (try? (modelContext?.fetch(fetchDescriptor) ?? [])) ?? []
        if !storedUsers.isEmpty {
            self.users = storedUsers
        } else {
            Task {
                await fetchUsers()
            }
        }
        
        func fetchUsers() async {
            isLoading = true
            errorMessage = nil
            
            do {
                let jsonURL = "https://www.hackingwithswift.com/samples/friendface.json"
                let fetchedUsers = try await UserService.shared.fetchUserData(from: jsonURL)
                
                // Ensure all SwiftData updates happen on the main thread
                await MainActor.run {
                    for user in fetchedUsers {
                        modelContext?.insert(user)
                    }
                    try? modelContext?.save()
                    self.users = fetchedUsers
                }
            } catch {
                self.errorMessage = error.localizedDescription
            }
            
            self.isLoading = false
        }
    }
}
