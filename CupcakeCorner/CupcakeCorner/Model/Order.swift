//
//  Order.swift
//  CupcakeCorner
//
//  Created by Sebastian Bușa on 7/2/25.
//

import Foundation
import Observation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _specialRequestEnabled = "specialRequestEnabled"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type: Int
    var quantity: Int
    var name: String
    var streetAddress: String
    var city: String
    var zip: String
    var extraFrosting: Bool
    var addSprinkles: Bool
    var specialRequestEnabled: Bool
    
    var hasValidAddress: Bool {
        !name.isEmpty && !streetAddress.isEmpty && !city.isEmpty && zip.count > 5
    }
    
    var cost: Decimal {
        // $2 per cupcake
        var cost = Decimal(quantity) * 2
        // Complicated cupcakes cost more
        cost += Decimal(type) / 2
        // $1/cupcake for extra frosting
        if extraFrosting { cost += Decimal(quantity) }
        // $0.5/cupcake for sprinkles
        if addSprinkles { cost += Decimal(quantity) / 2 }
        
        return cost
    }
    
    init(type: Int = 0,
         quantity: Int = 1,
         name: String = "",
         streetAddress: String = "",
         city: String = "",
         zip: String = "",
         extraFrosting: Bool = false,
         addSprinkles: Bool = false,
         specialRequestEnabled: Bool = false
    ) {
        self.type = type
        self.quantity = quantity
        self.name = name
        self.streetAddress = streetAddress
        self.city = city
        self.zip = zip
        self.extraFrosting = extraFrosting
        self.addSprinkles = addSprinkles
        self.specialRequestEnabled = specialRequestEnabled
    }
}
