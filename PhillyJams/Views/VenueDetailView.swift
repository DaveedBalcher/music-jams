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
                                .foregroundColor(neightborhoodTint)
                                .cornerRadius(8)
                                .shadow(radius: 8)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(venue.neighborhood?.name ?? "")
                            .font(.title3)
                            .fontWeight(.light)
                        Text("Genres: \(venue.genresDescription)")
                            .fontWeight(.light)
                        Text("Vibe: \(venue.vibe)")
                            .fontWeight(.light)
                    }
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(12)
                }
                .padding(12)


                // TODO: Add venue description
                
                Text("Events")
                    .font(.headline)
                    .padding()
                
                if venue.events.isEmpty {
                                    Text("List of jams and open mics coming soon...")
                                        .padding()
                                        .font(.callout)
                                        .foregroundStyle(.gray)
                } else {
                    ForEach(venue.events) { event in
                        HStack {
                            let title = [event.type, event.name].filter { !$0.isEmpty }.joined(separator: ": ")
                            let date = [event.dayOfTheWeek, event.startTime, event.endTime].filter { !$0.isEmpty }.joined(separator: " - ")
                            let hosts = event.hosts?.filter { !$0.isEmpty }.joined(separator: " and ")
                            
                            VStack(alignment: .leading) {
                                Text(title)
                                    .fontWeight(.semibold)
                                Text("Host(s): \(hosts ?? "unspecified")")
                                    .fontWeight(.light)
                                Text("Every \(date)")
                                    .fontWeight(.light)
                                if let url = URL(string: event.url ?? "") {
                                    Link("Visit Event Page", destination: url)
                                        .foregroundColor(.blue)
                                }
                            }
                            .font(.subheadline)
                            .padding(8)
                            
                            Spacer()
                        }
                        .padding([.leading, .trailing], 16)
                    }
                }
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
