//
//  VenueDetailView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/31/22.
//

import SwiftUI
import MusicVenues

struct VenueDetailView: View {
    let venue: VenueItem

    var body: some View {
        
        let neightborhoodTint = Color(venue.neighborhood?.color, defaultColor: .black)
        
        ScrollView {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    Image(systemName: "music.note")
                        .resizable()
                        .padding(90)
                        .foregroundColor(.white)
                        .scaledToFit()
                        .background(
                            Rectangle()
                                .foregroundColor(neightborhoodTint))
                    
                    VStack(alignment: .leading) {
                        Text(venue.neighborhood?.name ?? "")
                            .font(.title3)
                        Text("Genres: \(venue.genresDescription)")
                        Text("Vibe: \(venue.vibe.rawValue)")
                    }
                    .padding(12)
                    .font(.subheadline)
                    .foregroundColor(.white)
                }
                .padding(12)


                // TODO: Add venue description
            }
        }
        .navigationTitle(venue.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VenueDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VenueDetailView(venue: VenueItem.defaultItem)
    }
}
