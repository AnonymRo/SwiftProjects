//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Sebastian Bușa on 20/2/25.
//

import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {
    
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(container)
    }
    
    init() {
        // Custom container
        let schema = Schema([Book.self])
        let config = ModelConfiguration("MyBooks", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
        // Prints the local file system path where the SwiftData storage file is saved
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
