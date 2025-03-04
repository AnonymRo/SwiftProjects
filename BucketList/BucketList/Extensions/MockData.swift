//
//  Extensions.swift
//  BucketList
//
//  Created by Sebastian Bușa on 4/3/25.
//

import Foundation

extension Location {
#if DEBUG
    static let example = Location(id: UUID(),
                                  name: "Buckingham Palace",
                                  description: "Lit by over 40.000 lightbulbs",
                                  latitude: 51.501,
                                  longitude: -0.141)
#endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
