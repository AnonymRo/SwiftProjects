//
//  Location.swift
//  iForgot
//
//  Created by Sebastian Bușa on 10/3/25.
//

import MapKit
import SwiftData

@Model
class Location {
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
