//
//  NeighborhoodMapItem.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/1/22.
//

import SwiftUI
import MapKit
import MusicVenues

struct NeighborhoodMapItem {
    let name: String
    let center: CLLocationCoordinate2D
    let span: MKCoordinateSpan
    let color: Color?
    
    static var initialState: NeighborhoodMapItem {
        NeighborhoodMapItem(name: "Philadelphia",
                            center: CLLocationCoordinate2D(latitude: 39.9509, longitude: -75.1575),
                            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5),
                            color: nil)
    }
    
    var item: NeighborhoodItem {
        NeighborhoodItem(name: name,
                         center: Coordinates(latitude: center.latitude, longitude: center.longitude),
                         color: nil)
    }
}
