//
//  User.swift
//  iForgot
//
//  Created by Sebastian Bușa on 8/3/25.
//

import SwiftData
import CoreLocation

@Model
class User {
    @Attribute(.externalStorage) var photo: Data
    var name = ""
    var location: Location?
    
    init(photo: Data = Data(), name: String = "", location: Location? = nil) {
        self.photo = photo
        self.name = name
        self.location = location
    }
}
