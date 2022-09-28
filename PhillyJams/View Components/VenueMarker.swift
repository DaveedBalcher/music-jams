//
//  VenueMarker.swift
//  MusicJams (iOS)
//
//  Created by Daveed Balcher on 8/1/22.
//

import SwiftUI
import MusicVenues

struct VenueMarker: View {
    let venue: VenueItem
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            let neightborhoodTint = Color(venue.neighborhood?.color, defaultColor: Color.lightBlue)
            let primaryColor = isSelected ? .white : neightborhoodTint
            let secondaryColor = isSelected ? neightborhoodTint : .white
            Circle()
                .strokeBorder(secondaryColor, lineWidth: 1)
                .background(Circle().fill(primaryColor))
                .frame(width: 24, height: 24)
            
            Image(systemName: "music.note")
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
                .foregroundColor(secondaryColor)
                .padding()
        }
    }
}

//struct VenueMarker_Previews: PreviewProvider {
//    static var previews: some View {
//        VenueMarker()
//    }
//}
