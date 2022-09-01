//
//  NeighborhoodMapModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/1/22.
//

import Foundation
import MapKit
import MusicVenues

struct NeighborhoodMapModel {
    let center: CLLocationCoordinate2D
    let span: MKCoordinateSpan
    let neighborhoodItem: NeighborhoodItem
    
    static var initialState: NeighborhoodMapModel {
        NeighborhoodMapModel(
            center: CLLocationCoordinate2D(latitude: 39.9509, longitude: -75.1575),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5),
            neighborhoodItem: NeighborhoodItem(name: "Philadelphia", center: Coordinates.defaultValue, color: nil)
        )
    }
}
