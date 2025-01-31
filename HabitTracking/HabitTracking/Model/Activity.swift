//
//  Activity.swift
//  HabitTracking
//
//  Created by Sebastian Bușa on 30/1/25.
//

import Foundation

struct Activity: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var completionCount: Int
    
    init(id: UUID = UUID(), name: String, description: String, completionCount: Int = 0) {
        self.id = id
        self.name = name
        self.description = description
        self.completionCount = completionCount
    }
}
