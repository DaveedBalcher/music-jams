//
//  MapView.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 9/1/22.
//

import SwiftUI
import MapKit
import MusicVenues

struct MapView: View {
    let venues: [VenueItem]
    
    @Binding var mapRegion: MKCoordinateRegion
    @Binding var selectedVenue: VenueItem?
    
    init(venues: [VenueItem], mapRegion: Binding<MKCoordinateRegion>, selectedVenue: Binding<VenueItem?>) {
        self.venues = venues
        _mapRegion = mapRegion
        _selectedVenue = selectedVenue
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $mapRegion, annotationItems: venues) { venue in
                MapAnnotation(coordinate: venue.coordinates.mapCoordinates) {
                    Button {
                        selectedVenue = venue
                    } label: {
                        VenueMarker(venue: venue, isSelected: venue == selectedVenue)
                    }
                }
            }
            .padding([.top], -8)
            .animation(.default, value: mapRegion)
            .ignoresSafeArea()
            .edgesIgnoringSafeArea(.all)
            
            if let venue = selectedVenue {
                NavigationLink {
                    VenueDetailView(venue: venue)
                } label: {
                    VenueBottomView(venue: venue)
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(venues: [VenueItem.defaultItem],
                mapRegion: .constant(MainViewModel.zoomedOutMapRegion.mkRegion),
                selectedVenue: .constant(VenueItem.defaultItem))
    }
}
