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
            return 0.1
        case .two:
            return 0.025
        case .one:
            return 0.005
        }
    }
    var longitudeDelta: Double {
        switch level {
        case .three:
            return 0.09
        case .two:
            return 0.02
        case .one:
            return 0.004
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
