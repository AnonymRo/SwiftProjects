//
//  FriendsApp.swift
//  Friends
//
//  Created by Sebastian Bușa on 26/2/25.
//

import SwiftUI
import SwiftData

@main
struct FriendsApp: App {
    
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
        .modelContainer(container)
    }
    
    init() {
        // Custom container
        let schema = Schema([User.self])
        let config = ModelConfiguration("Friends", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container because: \(error.localizedDescription)")
        }
        
        // Prints the local file system path where the SwiftData storage file is saved
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
