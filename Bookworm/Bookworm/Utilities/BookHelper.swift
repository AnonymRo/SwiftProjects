//
//  BookHelper.swift
//  Bookworm
//
//  Created by Sebastian Bușa on 12/2/25.
//

import Foundation

class BookHelper {
    static func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
