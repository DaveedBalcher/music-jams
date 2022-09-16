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
                    Text("Genres: \(venue.genresDescription)")
                    Text("Vibe: \(venue.vibe)")
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
        .padding([.leading,.trailing], 12)
    }
}

struct VenueBottomView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            VenueBottomView(venue: VenueItem.defaultItem)
        }
    }
}
