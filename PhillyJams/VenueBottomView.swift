//
//  VenueBottomView.swift
//  MusicJams (iOS)
//
//  Created by Daveed Balcher on 8/1/22.
//

import SwiftUI
import MusicVenues

struct VenueBottomView: View {
    let venue: VenueItem
    
    var body: some View {
        
        let neightborhoodTint = Color(venue.neighborhood?.color, defaultColor: .white)
        
        HStack {
            Image(systemName: "music.note")
                .resizable()
                .padding()
                .foregroundColor(.white)
                .scaledToFit()
                .frame(width: 72, height: 72)
                .padding([.leading], 12)
                .background(
                    Rectangle()
                        .foregroundColor(neightborhoodTint)
                    
                        .padding([.leading], 12))
            
            VStack(alignment: .leading) {
                
                Text(venue.name)
                    .font(.headline)
                    .foregroundColor(neightborhoodTint)
                
                VStack(alignment: .leading) {
                    Text(venue.neighborhood?.name ?? "")
                    let genres = (venue.genres.map { $0.name}).joined(separator: ", ")
                    Text("Genres: \(genres)")
                    Text("Vibe: \(venue.vibe.rawValue)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding([.top], 8)
            
            
            Spacer()
        }
        
        .frame(maxWidth: .infinity, maxHeight: 96)
        .background(
            RoundedRectangle(cornerRadius: 8).foregroundColor(.white))
        .padding()
    }
}

//struct VenueBottomView_Previews: PreviewProvider {
//    static var previews: some View {
//        VenueBottomView(venue: Venue)
//    }
//}
