//
//  UserService.swift
//  Friends
//
//  Created by Sebastian Bușa on 26/2/25.
//

import Foundation

class UserService {
    static let shared = UserService()
    
    private init() {}
    
    func fetchUserData(from urlString: String) async throws -> [User] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.customISO8601)

        do {
            return try decoder.decode([User].self, from: data)
        } catch {
            print("❌ Decoding error: \(error)")
            throw error
        }
    }
}
