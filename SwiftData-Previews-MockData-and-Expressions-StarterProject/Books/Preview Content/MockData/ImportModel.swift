//
//  ImportModel.swift
//  Books
//
//  Created by Sebastian Bușa on 26/2/25.
//

import Foundation

struct ImportModel: Codable {
    struct GenreI: Codable {
        let name: String
        let color: String
    }
    
    struct AuthorI: Codable {
        let firstName: String
        let lastName: String
        let authorId: String
    }
    
    struct BookI: Codable {
        let name: String
        let genre: String
        let authorIds: [String]
    }
    
    let genres: [GenreI]
    let authors: [AuthorI]
    let books: [BookI]
    
    static func fetchMockData() -> ImportModel? {
        guard let url = Bundle.main.url(forResource: "MockData.json", withExtension: "") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        let importData = try? JSONDecoder().decode(ImportModel.self, from: data)
        return importData
    }
}
