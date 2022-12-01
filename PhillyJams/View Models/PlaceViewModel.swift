//
//  PlaceViewModel.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 11/15/22.
//

import SwiftUI
import MusicVenues

struct PlaceViewModel {
    let title: String
    let image: Image?
    let color: Color = .gray
    let properties: [Property]
    
    init(title: String, image: Image?, properties: [Property]) {
        self.title = title
        self.image = image
        self.properties = properties
    }
    
    init(place: Place) {
        self.title = place.title
        self.image = place.icon
        self.properties = place.properties
    }
}
