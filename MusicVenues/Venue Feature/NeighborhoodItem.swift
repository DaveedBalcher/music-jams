//
//  NeighborhoodItem.swift
//  MusicVenues
//
//  Created by Daveed Balcher on 8/22/22.
//

import Foundation


public struct NeighborhoodItem: Equatable, Hashable {
    public let name: String
//    public let center: Coordinates
    public let color: String?
    
    public var coordinates = [Coordinates]()
    public var center: Coordinates {
        coordinates.average
    }
    
    public init(name: String, color: String?) {
        self.name = name
        self.color = color
    }
    
    public static func == (lhs: NeighborhoodItem, rhs: NeighborhoodItem) -> Bool {
        lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
