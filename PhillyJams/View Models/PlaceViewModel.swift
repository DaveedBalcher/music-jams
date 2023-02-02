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
        
        let detailsFactory = PlaceDetailsFactory(place: place)
        self.urgencyDescription = detailsFactory.urgencyDescription
        self.details = detailsFactory.details
    }
}
