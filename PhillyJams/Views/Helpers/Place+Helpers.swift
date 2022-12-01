//
//  Place+Helpers.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/22/22.
//

import CoreLocation
import MusicVenues

extension Place {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
