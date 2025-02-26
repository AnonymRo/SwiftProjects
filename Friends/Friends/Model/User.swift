//
//  Model.swift
//  Friends
//
//  Created by Sebastian Bușa on 26/2/25.
//

import Foundation

struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}

struct User: Identifiable, Codable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
