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
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(neightborhoodTint)
                    
                        .padding([.leading], 12)
                )
                .padding([.trailing], 4)
            
            VStack(alignment: .leading) {
                
                Text(venue.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(neightborhoodTint)
                
                VStack(alignment: .leading) {
                    Text("Next Event: \(venue.nextDayOfEvent)")
                        .fontWeight(.light)
                    Text("Genres: \(venue.genresDescription)")
                        .fontWeight(.light)
                    Text("Vibe: \(venue.vibe)")
                        .fontWeight(.light)
                }
                .font(.subheadline)
                .foregroundColor(Color.accentColor)
                
                Spacer()
            }
            .padding([.top], 8)
            
            Spacer()
        }
        
        .frame(maxWidth: .infinity, maxHeight: 96)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.accentColor.opacity(0.25))
            }
            .shadow(color: Color.accentColor.opacity(0.25), radius: 8)
        )
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
