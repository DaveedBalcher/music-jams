//
//  Coordinates.swift
//  MusicVenues
//
//  Created by Daveed Balcher on 8/22/22.
//

import Foundation

public struct Coordinates {
    public let latitude: Double
    public let longitude: Double
}

public extension Coordinates {
    static var defaultValue = Coordinates(latitude: 39.9509, longitude: -75.1575)
}
