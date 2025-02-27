//
//  DateFormatterExtension.swift
//  Friends
//
//  Created by Sebastian Bușa on 26/2/25.
//

import Foundation

extension Array where Element == String {
    func toJSONString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return "[]" }
        return String(data: data, encoding: .utf8) ?? "[]"
    }
}

extension String {
    func toArray() -> [String] {
        guard let data = self.data(using: .utf8),
              let array = try? JSONSerialization.jsonObject(with: data, options: []) as? [String] else {
            return []
        }
        return array
    }
}
