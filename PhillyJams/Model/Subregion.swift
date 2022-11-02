//
//  NeighborhoodMapItem.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/1/22.
//

import SwiftUI
import MapKit
import MusicVenues

struct Subregion {
    let name: String
    let mkRegion: MKCoordinateRegion
    let color: Color?
}

extension Subregion: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension Collection where Element == NeighborhoodItem {
    func maptoSubregions() -> [Subregion] {
        map {
            Subregion(
                name: $0.name,
                mkRegion: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: $0.center.latitude, longitude: $0.center.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.02)),
                color: $0.color != nil ? Color($0.color!) : nil)
        }
    }
}
