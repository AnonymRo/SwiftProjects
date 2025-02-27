//
//  UserViewModel.swift
//  Friends
//
//  Created by Sebastian Bușa on 26/2/25.
//

import Foundation

struct MockData {
    static var users: [User] {
        [
            User(
                id: UUID(uuidString: "50a48fa3-2c0f-4397-ac50-64da464f9954")!,
                isActive: true,
                name: "John Doe",
                age: 30,
                company: "Apple",
                email: "johndoe@apple.com",
                address: "1 Infinite Loop, Cupertino, CA",
                about: "A passionate software engineer with experience in Swift and iOS development.",
                registered: Date().addingTimeInterval(-86_400 * 30), // 30 days ago
                tags: ["iOS", "Swift", "Xcode"],
                friends: [
                    createFriend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Alice Johnson"),
                    createFriend(id: "7ef1899e-96e4-4a76-8047-0e49f35d2b2c", name: "Bob Smith")
                ]
            ),
            User(
                id: UUID(uuidString: "eccdf4b8-c9f6-4eeb-8832-28027eb70155")!,
                isActive: false,
                name: "Jane Doe",
                age: 25,
                company: "Google",
                email: "janedoe@google.com",
                address: "1600 Amphitheatre Parkway, Mountain View, CA",
                about: "A creative designer with experience in UI/UX and front-end development.",
                registered: Date().addingTimeInterval(-86_400 * 10), // 10 days ago
                tags: ["UI/UX", "Figma", "SwiftUI"],
                friends: []
            )
        ]
    }

    /// Helper function to create a `Friend` instance
    private static func createFriend(id: String, name: String) -> Friend {
        Friend(id: UUID(uuidString: id)!, name: name)
    }
}
