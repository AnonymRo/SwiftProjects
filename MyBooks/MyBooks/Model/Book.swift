//
//  Book.swift
//  MyBooks
//
//  Created by Sebastian Bușa on 20/2/25.
//

import SwiftUI
import SwiftData

// Data model for Books
@Model
class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var summary: String
    var rating: Int?
    var status: Status.RawValue
    var recommendedBy: String = ""
    // One-to-Many relationship and the cascade deleting
    @Relationship(deleteRule: .cascade)
    var quotes: [Quote]?
    // Many-to-Many relationship and the key path for the inverse of it
    @Relationship(inverse: \Genre.books)
    var genres: [Genre]?
    
    // Saves a references to the actual photo
    @Attribute(.externalStorage)
    var bookCover: Data?
    
    init(
        title: String,
        author: String,
        dateAdded: Date = .now,
        dateStarted: Date = .distantPast,
        dateCompleted: Date = .distantPast,
        summary: String = "",
        rating: Int? = nil,
        status: Status = .onShelf,
        recommendedBy: String = ""
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status.rawValue
        self.recommendedBy = recommendedBy
    }
    
    // Computed property for status icons
    var icon: Image {
        switch Status(rawValue: status)! {
        case .onShelf:
            Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            Image(systemName: "book.fill")
        case .completed:
            Image(systemName: "books.vertical.fill")
        }
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    var id: Self {
        self
    }
    var descr: LocalizedStringResource {
        switch self {
        case .onShelf:
            "On Shelf"
        case .inProgress:
            "In Progress"
        case .completed:
            "Completed"
        }
    }
}
