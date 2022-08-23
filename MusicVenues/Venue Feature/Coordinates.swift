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
    static var defaultValue: Coordinates {
        Coordinates(latitude: 39.9509, longitude: -75.1575)
    }
}

public extension Collection where Element == Coordinates {
    var average: Coordinates {
        Coordinates(latitude: self.map { $0.latitude}.average, longitude: self.map { $0.longitude}.average)
    }
}

extension Array where Element: BinaryFloatingPoint {

    /// The average value of all the items in the array
    var average: Double {
        if self.isEmpty {
            return 0.0
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }
}
