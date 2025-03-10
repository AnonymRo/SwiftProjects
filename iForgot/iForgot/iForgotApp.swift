//
//  iForgotApp.swift
//  iForgot
//
//  Created by Sebastian Bușa on 8/3/25.
//

import SwiftUI
import SwiftData

@main
struct iForgotApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            PhotoListView()
                .modelContainer(container)
        }
    }
    
    init() {
        let schema = Schema([User.self])
        let config = ModelConfiguration("iForgot", schema: schema)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
        
        #if DEBUG
        // Prints the local file system path where the SwiftData storage file is saved
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        #endif
    }
}
