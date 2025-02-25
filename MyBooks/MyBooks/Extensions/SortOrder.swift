//
//  SortOrder.swift
//  MyBooks
//
//  Created by Sebastian Bușa on 25/2/25.
//

import Foundation

enum SortOrder: LocalizedStringResource, Identifiable, CaseIterable {
    case status, title, author
    
    var id: Self {
        self
    }
}
