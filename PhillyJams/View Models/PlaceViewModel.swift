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
    let image: Image
    let color: Color
    
    let urgencyDescription: String?
    let type: String
    let genres: String
    let vibes: String
    
    var urgencyDescriptionWidth: CGFloat {
        urgencyDescription?.size(withAttributes: [.font: UIFont.preferredFont(forTextStyle: .footnote)]).width ?? 0
    }
    
    init(place: Place) {
        self.title = place.title
        self.image = place.icon ?? Image(systemName: "music.note")
        self.color = place.regionLevelOne.color
        
        self.urgencyDescription = place.properties.dictonary["urgency"]?.first?.capitalized
        self.type = place.properties.dictonary["types"]?.first?.capitalized ?? "No scheduled events"
        self.genres = (place.properties.dictonary["genres"]?.map { $0.capitalized })?.joined(separator: ", ") ?? "Unspecified"
        self.vibes = (place.properties.dictonary["vibes"]?.map { $0.capitalized })?.joined(separator: ", ") ?? "Unspecified"
    }
}
