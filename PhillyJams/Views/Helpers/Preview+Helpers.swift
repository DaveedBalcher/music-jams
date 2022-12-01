//
//  Preview + Helpers.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/22/22.
//

import Foundation
import MapKit
import MusicVenues

extension Region {
    static var preview: Region {
        Region(title: "Fishtown",
               colorString: "006BB6",
               level: .one,
               latitude: 39.9509,
               longitude: -75.1575
        )
    }
}

extension Place {
    static var preview: Place {
        Place(title: "Bar",
              latitude: 39.9509,
              longitude: -75.1575,
              regionLevelOne: Region.preview,
              properties: [])
    }
}

extension Event {
    static var preview: Event {
        let date = Date()
        
        return Event(title: "Title",
                     description: "Description",
                     hosts: ["Host"],
                     dates: [date],
                     duration: 60,
                     properties: [],
                     url: nil)
    }
}

extension Property {
    static var preview: Property {
        Property(title: "Title", values: ["Value"])
    }
}
