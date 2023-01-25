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
    
    let details: [String]
    
    let urgencyDescription: String?
    var urgencyDescriptionWidth: CGFloat {
        urgencyDescription?.size(withAttributes: [.font: UIFont.preferredFont(forTextStyle: .footnote)]).width ?? 0
    }
    
    init(place: Place) {
        self.title = place.title
        self.image = place.icon ?? Image(systemName: "music.note")
        self.color = place.regionLevelOne.color
        
        self.urgencyDescription = place.properties.dictonary["urgency"]?.first?.capitalized
        
        var newDetails = [String]()
        
        if let type = place.properties.dictonary["types"]?.first?.capitalized {
            newDetails.append("Type: \(type)")
        }
        if let genres = (place.properties.dictonary["genres"]?.map { $0.capitalized })?.joined(separator: ", ")  {
            newDetails.append("Genres: \(genres)")
        }
        if let vibes = (place.properties.dictonary["vibes"]?.map { $0.capitalized })?.joined(separator: ", ") {
            newDetails.append("Vibe: \(vibes)")
        }
        if newDetails.isEmpty {
            newDetails.append("Event details unspecified")
        }
        
        self.details = newDetails
    }
}
