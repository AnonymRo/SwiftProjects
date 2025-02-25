//
//  Genre.swift
//  MyBooks
//
//  Created by Sebastian Bușa on 25/2/25.
//

import SwiftUI
import SwiftData

@Model
class Genre {
    var name: String
    var color:  String
    // Many-to-Many relationship
    var books: [Book]?
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
