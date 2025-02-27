//
//  UserViewModel.swift
//  Friends
//
//  Created by Sebastian Bușa on 26/2/25.
//

import Foundation
import SwiftData

@Model
class User: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }
    
    var id = UUID()
    var isActive: Bool = false
    var name: String = ""
    var age: Int = 0
    var company: String = ""
    var email: String = ""
    var address: String = ""
    var about: String = ""
    var registered: Date = Date.now
    var tagsJSON: String = "[]"
    @Relationship(inverse: \Friend.users) var friends: [Friend]?

    /// **Computed property to use `[String]` while keeping `tagsJSON` as a `String` for storage**
    var tags: [String] {
        get { tagsJSON.toArray() }
        set { tagsJSON = newValue.toJSONString() }
    }
    
    init(id: UUID = UUID(),
         isActive: Bool = false,
         name: String = "",
         age: Int = 0,
         company: String = "",
         email: String = "",
         address: String = "",
         about: String = "",
         registered: Date = Date(),
         tags: [String] = [],
         friends: [Friend] = []
    ) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tagsJSON = tags.toJSONString()
        self.friends = friends
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)

        if let tagsArray = try? container.decode([String].self, forKey: .tags) {
            self.tagsJSON = tagsArray.toJSONString()
        } else {
            self.tagsJSON = "[]"
        }

        self.friends = try container.decodeIfPresent([Friend].self, forKey: .friends)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(registered, forKey: .registered)

        let tagsArray = tagsJSON.toArray()
        try container.encode(tagsArray, forKey: .tags)

        if let friends = friends {
            try container.encode(friends, forKey: .friends)
        }
    }
}
