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
    public let events: [Event]
    public var icon: Image?
    
    public var properties: [Property] {
        guard !events.isEmpty else { return [] }
        
        var dict = [String: [String]]()
        for event in events {
            for (key, value) in event.properties.dictonary {
                dict[key, default: []].append(contentsOf: value)
            }
        }
        
        if let date = events.first?.dates.first {
            let midNight: Date = Calendar.current.date(bySettingHour: 00, minute: 0, second: 0, of: Date())!
            let startOfToday = Calendar.current.date(byAdding: .day, value: 0, to: midNight)!
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: midNight)!
            let dayAfterTomorrow = Calendar.current.date(byAdding: .day, value: 2, to: midNight)!
            
            if date > startOfToday {
                if date < tomorrow {
                    dict["urgency"] = ["today"]
                } else if date < dayAfterTomorrow {
                    dict["urgency"] = ["tomorrow"]
                }
            }
        }
        
        return dict.map {
            Property(title: $0.key, values: $0.value)
        }.sorted()
    }
    
    public init(title: String, latitude: Double, longitude: Double, levelOneRegion: Region, events: [Event], icon: Image? = nil) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.regionLevelOne = levelOneRegion
        self.events = events
        self.icon = icon
    }
}

extension Place: Identifiable, Equatable {
    public static func == (lhs: Place, rhs: Place) -> Bool {
        lhs.title == rhs.title
    }
}
