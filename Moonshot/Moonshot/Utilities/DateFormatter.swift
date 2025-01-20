//
//  DateFormatter.swift
//  Moonshot
//
//  Created by Sebastian Bușa on 20/1/25.
//

import Foundation

extension Date {
    func toAbbreviatedString() -> String {
        self.formatted(date: .abbreviated, time: .omitted)
    }
}
