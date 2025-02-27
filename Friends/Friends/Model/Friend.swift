//
//  Friend.swift
//  Friends
//
//  Created by Sebastian Bușa on 26/2/25.
//

import Foundation
import SwiftData

@Model
class Friend: Identifiable, Codable {
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    var id = UUID()
    var name: String = ""
    // Many-to-Many relationship
    @Relationship var users: [User] = []
    
    init(id: UUID = UUID(), name: String = "", users: [User] = []) {
        self.id = id
        self.name = name
        self.users = users
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}
