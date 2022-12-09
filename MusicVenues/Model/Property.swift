//
//  Property.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/15/22.
//

import Foundation

public struct Property {
    public let title: String
    public var values: [String]
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

extension Property: Comparable {
    public static func < (lhs: Property, rhs: Property) -> Bool {
        lhs.title < rhs.title
    }
}

public extension Collection where Element == Property {
    var dictonary: [String: [String]] {
        var dict = [String: [String]]()
        self.forEach {
            dict[$0.title] = $0.values
        }
        return dict
    }
}
