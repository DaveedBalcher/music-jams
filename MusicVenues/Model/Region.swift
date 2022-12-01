//
//  Region.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/14/22.
//

import MapKit

public enum RegionLevel {
    case one, two, three
}

public struct Region {
    public let title: String
    public let colorString: String
    public let level: RegionLevel
    public let latitude: Double
    public let longitude: Double
    
    public init(title: String, colorString: String, level: RegionLevel, latitude: Double, longitude: Double) {
        self.title = title
        self.colorString = colorString
        self.level = level
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Region: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.latitude > rhs.latitude
    }
}

extension Region: Equatable {
    public static func == (lhs: Region, rhs: Region) -> Bool {
        lhs.title == rhs.title
    }
}
