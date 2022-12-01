//
//  Place.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/14/22.
//

import SwiftUI
import CoreLocation

public struct Place  {
    public let id = UUID()
    public let title: String
    public let latitude: Double
    public let longitude: Double
    public let regionLevelOne: Region
    public let events = [Event]()
    public var icon: Image?
    public let properties: [Property]
    
    public init(title: String, latitude: Double, longitude: Double, regionLevelOne: Region, icon: Image? = nil, properties: [Property]) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.regionLevelOne = regionLevelOne
        self.icon = icon
        self.properties = properties
    }
}

extension Place: Identifiable, Equatable {
    public static func == (lhs: Place, rhs: Place) -> Bool {
        lhs.title == rhs.title
    }
}
