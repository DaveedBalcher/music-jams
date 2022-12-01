//
//  Property.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/15/22.
//

import Foundation

public struct Property {
    public let title: String
    public let values: [String]
    public let isHighlighted: Bool = false
    
    public init(title: String, values: [String]) {
        self.title = title
        self.values = values
    }
}

extension Property: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
