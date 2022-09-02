//
//  NeighborhoodMapItem.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/1/22.
//

import SwiftUI
import MapKit
import MusicVenues

struct MapRegionItem {
    let name: String
    let region: MKCoordinateRegion
    let color: Color?
    
    static var initialState: MapRegionItem {
        MapRegionItem(
            name: "Philadelphia",
            region: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 39.9509, longitude: -75.1575),
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)),
            color: nil)
    }
}

extension MapRegionItem: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension Collection where Element == NeighborhoodItem {
    func maptoMapRegionItems() -> [MapRegionItem] {
        map {
            MapRegionItem(
                name: $0.name,
                region: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: $0.center.latitude, longitude: $0.center.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.02)),
                color: $0.color != nil ? Color($0.color!) : nil)
        }
    }
}
