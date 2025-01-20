//
//  Mission.swift
//  Moonshot
//
//  Created by Sebastian Bușa on 17/1/25.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    // Computed properties for missions names and images
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        launchDate?.toAbbreviatedString() ?? "N/A"
    }
}
