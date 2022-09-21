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
                        Text("Vibe: \(venue.vibe)")
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
                                Text("Every \(date)")
                                if let url = URL(string: event.url ?? "") {
                                    Link("Visit Event Page", destination: url)
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
