//
//  Region+Helpers.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/22/22.
//

import SwiftUI
import MapKit
import MusicVenues

extension Region {
    var latitudeDelta: Double {
        switch level {
        case .three:
            return 0.5
        case .two:
            return 0.145
        case .one:
            return 0.025
        }
    }
    var longitudeDelta: Double {
        switch level {
        case .three:
            return 0.4
        case .two:
            return 0.125
        case .one:
            return 0.02
        }
    }
    var color: Color {
        Color(colorString)
    }
    
    var center: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var span: MKCoordinateSpan {
        MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
    }
    
    var mkRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: center, span: span)
    }
}

extension Region: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

extension Region {
    static var defaultLevelTwo: Region {
        Region(
            title: "Philadelphia",
            colorString: "006BB6",
            level: .two,
            latitude: 39.975,
            longitude: -75.175
        )
    }
}
