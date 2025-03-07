//
//  RadialGradient.swift
//  GuessTheFlag
//
//  Created by Sebastian Bușa on 6/3/25.
//

import SwiftUI

extension RadialGradient {
    static var appBackground: RadialGradient {
        RadialGradient(stops: [
            .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
            .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
        ], center: .top, startRadius: 200, endRadius: 400)
    }
}
