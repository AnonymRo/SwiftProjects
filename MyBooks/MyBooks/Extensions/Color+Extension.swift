//
//  Color+Extension.swift
//  MyBooks
//
//  Created by Sebastian Bușa on 25/2/25.
//

import SwiftUI

extension Color {
    
    init?(hex: String) {
        guard let uiColor = UIColor(hex: hex) else { return nil }
        self.init(uiColor: uiColor)
    }
    
    func toHexString(includeAlpha: Bool = false) -> String? {
        return UIColor(self).toHexString(includeAlpha: includeAlpha)
    }
    
}
